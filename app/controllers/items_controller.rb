class ItemsController < ApplicationController
  # rescue_from StandardError, with: :handle_standard_error
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
    if current_user == nil
      flash[:alert] = "You must be logged in."
      redirect_to new_user_session_path
    end
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
    @item = Item.new(item_params)
    @item.seller_id = current_user.id
    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
    
  end


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

  def destroy
    @item.destroy!

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:seller_id, :category_id, :name, :description, :status)
  end

  # def handle_standard_error
  #   redirect_to error_path, alert: 'Something went wrong'
  # end
end
