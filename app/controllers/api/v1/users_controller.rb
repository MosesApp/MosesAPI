class Api::V1::UsersController < ApplicationController
  before_action :doorkeeper_authorize!
  respond_to :json

  def show
    respond_with current_user
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "user not found" }, status: 422
  end

  def update
    user = current_user
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "user not found" }, status: 422
  end

  def destroy
    current_user.try(:destroy)
    head 204
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "user not found" }, status: 422
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :full_name, :email,
                            :facebook_id, :locale, :timezone)
    end

end
