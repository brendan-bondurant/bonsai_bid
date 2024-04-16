class InquiriesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_item, only: [:create]

  def create
    @inquiry = @item.inquiries.new(inquiry_params)
    @inquiry.commenter = current_user
    @inquiry.seller_id = @item.seller_id
    if @inquiry.save
      flash[:notice] = 'Inquiry posted successfully.'
      redirect_to item_path(@item)
    else
      set_item
      flash.now[:alert] = "Comment can't be blank"
      render 'items/show', status: :unprocessable_entity
    end
  end

  def show
    
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Item not found.'
    redirect_to items_path
  end

  def inquiry_params
    params.require(:inquiry).permit(:comment)
  end
end
