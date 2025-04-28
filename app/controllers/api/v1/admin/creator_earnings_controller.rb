class Api::V1::Admin::CreatorEarningsController < ApplicationController
  before_action :authorize_admin_earnings

  def index
    earnings = Admin::CreatorEarningsService.new.call

    render json: earnings
  end

  private

  def authorize_admin_earnings
    authorize! :read, :admin_earnings
  end
end
