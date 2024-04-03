class RepliesController < ApplicationController
  before_action :set_feedback
  before_action :set_sale_transaction


  def index
  end

  def create
    @reply = @feedback.replies.build(reply_params)

    @reply.save
      redirect_to @feedback, notice: 'Reply was successfully created.'

  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:feedback_id])
  end

  def set_sale_transaction
    require 'pry'; binding.pry
    @sale_transaction = SaleTransaction.find(params[:sale_transaction_id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end
