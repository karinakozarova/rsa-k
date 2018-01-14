require 'spec_helper'
require 'rails_helper'
require 'openssl'

RSpec.describe DecryptMessagesController do
  describe 'POST /rsas/:id/decrypt_messages/' do
    before :each do
      @key = OpenSSL::PKey::RSA.new 2048
      @rsa = Rsa.create(n: @key.params['n'], e: @key.params['e'], d: @key.params['d'])

      encr = @key.public_encrypt('random long string with шано символи and numbers12134235534s')
      encoded = Base64.strict_encode64(encr)
      @mssg = @rsa.messages.create(content: encoded)
    end

    describe 'POST' do
      subject do
        post :create, params: { rsa_id: @rsa.id, message: @mssg.content }, format: :json
      end

      it 'should return json' do
        subject
        expect(response.content_type).to eq 'application/json'
      end

      it 'is okay' do
        subject
        (expect(response.status).to eq(200))
      end
    end
  end
end
