require 'spec_helper'
require 'rails_helper'
require 'openssl'

RSpec.describe EncryptMessagesController do
  describe 'Encrypt message tests' do
    before(:each) do
      key = OpenSSL::PKey::RSA.new 2048
      @rsa = Rsa.create(n: key.params['n'], e: key.params['e'], d: key.params['d'])
    end

    describe 'POST /rsas/:id/encrypt_messages/'  do
      subject do
        post :create, params: { rsa_id: @rsa.id, message: 'random lons string 20456565445 -1' }, format: :json
      end

      it 'should encrypt the given message and return its id' do
        old_count = Message.count
        subject
        expect(Message.count).to eq old_count + 1
      end

      it 'should return json' do
        subject
        expect(response.content_type).to eq 'application/json'
      end
    end

    describe 'GET /rsas/:id/encrypt_messages/:id' do
      before :each do
        @key = OpenSSL::PKey::RSA.new 2048
        @rsa = Rsa.create(n: @key.params['n'], e: @key.params['e'], d: @key.params['d'])

        encrypted = @key.public_encrypt('random long string with шано символи and numbers12134235534s')
        encoded = Base64.strict_encode64(encrypted)
        @message = @rsa.messages.create(content: encoded)
      end

      subject do
        get :show, params: { rsa_id: @rsa.id, id: @message.id }, format: :json
      end

      it 'should return json' do
        subject
        expect(response.content_type).to eq 'application/json'
      end

    end
  end

end
