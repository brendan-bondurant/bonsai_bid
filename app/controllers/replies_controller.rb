class RepliesController < ApplicationController
  before_action :set_parent_object
  before_action :set_reply, only: [:edit, :update, :destroy]

  def index
  end

  def edit
  end

  def update
    if @reply.update(reply_params)
      redirect_to return_path, notice: 'Reply was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @reply.destroy
      redirect_to return_path, notice: 'Reply deleted.'
    else
      redirect_to return_path, alert: 'There was a problem deleting the reply.'
    end
  end

  def create
    require 'pry'; binding.pry
    @reply = @parent.replies.build(reply_params)
    @reply.user_id = current_user.id 
    @reply.save
      redirect_to return_path, notice: 'Reply was successfully created.'

  end

  private

  def set_parent_object
    if params[:feedback_id]
      @parent = Feedback.find(params[:feedback_id])
      @sale_transaction = SaleTransaction.find(params[:sale_transaction_id]) if params[:sale_transaction_id]
    # elsif params[:reply]
    #   require 'pry'; binding.pry
    #   @parent = Reply.find(params[:reply_id])
    elsif params[:inquiry_id]
      @parent = Inquiry.find(params[:inquiry_id])
    end
  end

  def set_reply
    @reply = @parent.replies.find(params[:id])
    require 'pry'; binding.pry
  end

  def reply_params

    params.require(:reply).permit(:content)
  end

  def return_path
    if @parent.is_a?(Feedback)
      sale_transaction_feedback_path(@sale_transaction, @parent)
    elsif @parent.is_a?(Inquiry)
      item_path(@parent.item) 
    end
  end
end
