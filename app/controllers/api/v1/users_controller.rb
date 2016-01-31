class Api::V1::UsersController < ApplicationController
  respond_to :json
  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :full_name, :email,
                            :facebook_id, :locale, :timezone)
    end

end