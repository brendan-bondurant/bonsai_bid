class SaleTransactionsController < ApplicationController
  before_action :set_sale_transaction, only: %i[ show ]
  # skip_before_action :authenticate_user!, only: [:index], raise: false
  before_action :set_user, only: [:index], if: :user_signed_in?

  def index
    if @user
      @sales = @user.sales
      @purchases = @user.purchases
    else
      redirect_to new_user_session_path, alert: "You need to sign in or sign up before continuing."
    end
  end

  def show
  end


  private
  def set_sale_transaction
    @sale_transaction = SaleTransaction.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end