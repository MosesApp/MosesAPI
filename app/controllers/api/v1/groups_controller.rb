class Api::V1::GroupsController < ApplicationController
  before_action :doorkeeper_authorize!
  respond_to :json

  def show
    respond_with Group.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "group not found" }, status: 422
  end

  def create
    group = Group.new(group_params)
    if group.save
      render json: group, status: 201, location: [:api, group]
    else
      render json: { errors: group.errors }, status: 422
    end
  end

  private

    def group_params
      params.require(:group).permit(:name, :creator_id, :avatar, :status)
    end
end
