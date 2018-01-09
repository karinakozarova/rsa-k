require 'openssl'

class RsasController < ApplicationController
  before_action :set_rsa, only: %i[show edit update destroy]

  def create
    key = OpenSSL::PKey::RSA.new 2048
    if params_ok then write_ned key end
    @rsa = create_rsa
    respond_to :json
  end

  def write_ned(key)
    key.n = params[:n].to_i
    key.e = params[:e].to_i
    key.d = params[:d].to_i
  end

  def show
    respond_to :json
  end

  def create_rsa
    Rsa.create(n: key.params['n'], e: key.params['e'], d: key.params['d'])
  end

  def set_rsa
    @rsa = Rsa.find_by(id: params[:id])
  end

  def params_ok
    params[:n] && params[:e] && params[:d]
  end
end
