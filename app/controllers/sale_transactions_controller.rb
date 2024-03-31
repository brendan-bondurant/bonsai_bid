class SaleTransactionsController < ApplicationController
  before_action :set_sale_transaction

  def show
  end


  private
  def set_sale_transaction
    @sale_transaction = SaleTransaction.find(params[:id])
  end
end