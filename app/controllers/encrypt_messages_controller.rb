require 'openssl'

class EncryptMessagesController < ApplicationController
  before_action :set_rsa
  before_action :set_message, only: :show

  def create
    key = OpenSSL::PKey::RSA.new 2048
    set_ned key
    encrypted = key.public_encrypt(params[:message])
    encoded = Base64.strict_encode64(encrypted)
    @message = @rsa.messages.create(content: encoded)
    respond_to :json
  end

  def set_ned(key)
    key.n = @rsa.n.to_i
    key.e = @rsa.e.to_i
    key.d = @rsa.d.to_i
  end

  def show
    respond_to :json
  end

  private

  def set_rsa
    @rsa = Rsa.find params[:rsa_id]
  end

  def set_message
    @message = @rsa.messages.find params[:id]
  end
end
