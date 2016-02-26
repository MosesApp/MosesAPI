class Api::V1::BillsController < ApplicationController
  before_action :doorkeeper_authorize!
  respond_to :json

  def index
    respond_with Bill.find_all(current_user), hide_details: true
  end

  def show
    bill = Bill.find(params[:id], current_user)
    if bill != nil
      respond_with bill
    else
      render json: { errors: "bill not found" }, status: 422
    end
  end

  def group_index
    group = Group.find(params[:group_id], current_user)
    if group != nil
      respond_with group.bills, hide_details: true
    else
      render json: { errors: "group not found" }, status: 422
    end
  end

  private

    def bill_params
      params.require(:bill).permit(:name, :description, :group_id,
                                                    :currency_id, :amount)
    end

end
