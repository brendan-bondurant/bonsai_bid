class RepliesController < ApplicationController
  before_action :set_feedback
  before_action :set_sale_transaction


  def index
  end

  def edit
    @reply = @feedback.replies.find(params[:id])
  end
 
  def update
    @reply = @feedback.replies.find(params[:id])

    if @reply.update(reply_params)
      redirect_to sale_transaction_feedback_path(@sale_transaction, @feedback), notice: 'Reply was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @reply = @feedback.replies.find(params[:id])
  
    if @reply.destroy
      redirect_to sale_transaction_feedback_path(@sale_transaction, @feedback), notice: 'Reply deleted.'
    else
      redirect_to sale_transaction_feedback_path(@sale_transaction, @feedback), alert: 'There was a problem deleting the reply.'
    end
  end
  def create
    @reply = @feedback.replies.build(reply_params)
    @reply.author = current_user

    if @reply.save
      redirect_to sale_transaction_feedback_path(@sale_transaction, @feedback), notice: 'Reply was successfully created.'
    end

  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:feedback_id])
  end

  def set_sale_transaction
    @sale_transaction = SaleTransaction.find(params[:sale_transaction_id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end
