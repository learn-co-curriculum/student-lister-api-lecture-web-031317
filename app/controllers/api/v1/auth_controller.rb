class Api::V1::AuthController < ApplicationController

  def create
    account = Account.find_by(username: params[:username])
    if account.present? && account.authenticate(params[:password])
      token = JWT.encode({account_id: account.id}, ENV['JWT_SECRET'], ENV['JWT_ALOGIRTHM'])
      render json: {
        account: {username: account.username},
        token: token
      }
    end
  end
end