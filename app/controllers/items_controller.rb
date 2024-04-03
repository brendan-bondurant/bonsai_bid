class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
    @item = Item.find(params[:id])
    @category = Category.find(@item.category_id)
    @inquiry = Inquiry.new
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    if current_user.id != @item.seller_id
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end

  # POST /items or /items.json
  def create
    item = Item.new(item_params)
    item.current_price = item.starting_price
    item.seller_id = current_user.id
    respond_to do |format|
      if item.save
        format.html { redirect_to item_url(item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        @item.reload #Remove if you want it to stay with the incorrect data
        @item.errors.full_messages
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy!

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end
  def item_params
    params.require(:item).permit(:seller_id, :category_id, :name, :description, :starting_price, :current_price, :buy_it_now_price, :start_date, :bid_increment, :end_date, :status)
  end
end
