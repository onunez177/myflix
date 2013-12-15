class BillingsController < ApplicationController

  def show
    @user = BillingDecorator.new(User.find(current_user.id))
  end

end