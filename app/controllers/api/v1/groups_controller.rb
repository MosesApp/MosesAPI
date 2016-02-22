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
    #Add creator
    create_params = group_params
    create_params[:creator_id] = current_user[:id]
    #Create group
    group = Group.create!(create_params)
    #Add members
    group.add_members(members_params[:add_members])

    render json: group, status: 201, location: [:api, group], show_users: true
  rescue ActiveRecord::RecordInvalid => invalid
      render json: { errors: invalid.record.errors }, status: 422
  end

  def update
    group = Group.find(params[:id], current_user)
    if group == nil
      render json: { errors: "group not found" }, status: 422
    elsif group.update(group_params)
      group.add_members(members_params[:add_members])
      group.remove_members(members_params[:remove_members])
      render json: group, status: 200, location: [:api, group], show_users: true
    else
      render json: { errors: group.errors }, status: 422
    end
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
      params.require(:group).permit(:name, :avatar, :status)
    end

    def members_params
      params.require(:group).permit(add_members: [:id, :is_admin],
                                    remove_members: [:id, :is_admin])
    end
end
