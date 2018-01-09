require 'openssl'

class DecryptMessagesController < ApplicationController
  before_action :create_rsa
  before_action :create_message, only: :show

  def create
    key = OpenSSL::PKey::RSA.new 2048
    create_ned key
    decoded = decode
    @decrypted = key.private_decrypt(decoded)
    respond_to :json
  end

private

  def create_ned(key)
    key.n = @rsa.n.to_i
    key.e = @rsa.e.to_i
    key.d = @rsa.d.to_i
  end

  def decode
    decoded = Base64.decode64(params[:message])
    puts decoded
    decoded
  end

  def create_rsa
    @rsa = Rsa.find params[:rsa_id]
  end
  
  def create_message
    @message = @rsa.messages.find params[:id]
  end
end

