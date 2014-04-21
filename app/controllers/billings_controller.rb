class BillingsController < ApplicationController
  before_action :require_user

  def show
    @user = BillingDecorator.new(current_user)
  end
end