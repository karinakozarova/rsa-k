require 'spec_helper'
require 'rails_helper'

RSpec.describe RsasController do
  	describe 'POST' do

	    subject do
	      post :create, format: :json      
	    end

	    it 'should generate new key and return its id' do
	      old_count = Rsa.count
	      subject
	      expect(Rsa.count).to eq old_count + 1
	      expect(response.content_type).to eq 'application/json'
	    end

	    it "should return key id as JSON" do
	      subject
	      expect(response.content_type).to eq 'application/json'
	    end

	    it 'should return json' do
	      subject
	      expect(response.content_type).to eq 'application/json'
	    end

  	end

	describe 'GET' do
		
		subject do
			get :show, params: { id: "1" }, format: :json
	    end

		it 'should return json' do
	      subject
	      expect(response.content_type).to eq 'application/json'
	    end

	end
end