require 'openssl'

class RsasController < ApplicationController
  before_action :rsa, only: %i[show edit update destroy]

  def create
    key = OpenSSL::PKey::RSA.new 2048
    ned(key) if params[:n] && params[:e] && params[:d]
    @rsa = Rsa.create(n: key.params['n'], e: key.params['e'], d: key.params['d'])
    respond_to :json
  end

  def ned(key)
    key.n = params[:n].to_i
    key.e = params[:e].to_i
    key.d = params[:d].to_i
  end

  def show
    respond_to :json
  end

  def rsa
    @rsa = Rsa.find_by(id: params[:id])
  end
end
