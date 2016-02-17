class Api::V1::GroupsController < ApplicationController
  before_action :doorkeeper_authorize!
  respond_to :json

  def index
    respond_with current_user.groups
  end

  def show
    group =  Group.includes([:users, :group_users]).where(id: params[:id],
                                      group_users: { user: current_user } ).first

    if group != nil
      respond_with group
    else
      render json: { errors: "group not found" }, status: 422
    end
  end

  def create
    params = group_params
    params[:creator_id] = current_user[:id]

    group = Group.new(params)
    #TODO: Add group members
    if group.save
      render json: group, status: 201, location: [:api, group]
    else
      render json: { errors: group.errors }, status: 422
    end
  end

  private

    def group_params
      params.require(:group).permit(:name, :avatar, :status)
    end
end
