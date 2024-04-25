class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  def index
    # @items = Item.all
  end

  def show
    # @category = Category.find(@item.category_id)
    # @inquiry = Inquiry.new
  end

  def new
    if current_user.nil?
      flash[:alert] = "You must be logged in."
      redirect_to new_user_session_path
    else
      @item = Item.new
      @item.build_auction # Initialize the auction here
    end
  end

  def edit
    if current_user.id != @item.seller_id
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end

  def create
    @item = Item.new(item_params)
    @item.seller_id = current_user.id
    # Set default auction attributes if needed here or in the model via a callback
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: "Item and associated auction were successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # respond_to do |format|
    #   if @item.update(item_params)
    #     format.html { redirect_to @item, notice: "Item was successfully updated." }
    #     format.json { render :show, status: :ok, location: @item }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @item.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    # @item.destroy
    # respond_to do |format|
    #   format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:seller_id, :category_id, :name, :description, :status, auction_attributes: [:start_date, :end_date, :starting_price, :bid_increment, :status])
  end
end
