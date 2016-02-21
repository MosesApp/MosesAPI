class Api::V1::GroupsController < ApplicationController
  before_action :doorkeeper_authorize!
  respond_to :json

  def index
    respond_with current_user.groups
  end

  def show
    group = Group.find(params[:id], current_user)
    if group != nil
      respond_with group, show_users: true
    else
      render json: { errors: "group not found" }, status: 422
    end
  end

  def create
    group = Group.create!(group_params)
    group.add_members(members_params) if members_params.present?
    render json: group, status: 201, location: [:api, group], show_users: true
  rescue ActiveRecord::RecordInvalid => invalid
      render json: { errors: invalid.record.errors }, status: 422
  end

  def destroy
    group = Group.find(params[:id], current_user)
    if group == nil
      render json: { errors: "group not found" }, status: 422
    elsif GroupUser.where(group: group, user: current_user).first.is_admin
      group.try(:destroy)
      head 204
    else
      render json: { errors: "not allowed" }, status: 422
    end
  end

  private

    def group_params
      params[:creator_id] = current_user[:id]
      params.require(:group).permit(:name, :avatar, :status, :creator_id)
    end

    def members_params
      params.require(:group).permit(members: [:id, :is_admin])[:members]
    end
end
