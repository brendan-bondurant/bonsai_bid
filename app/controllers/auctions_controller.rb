class AuctionsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_auction, only: [:show]

  # GET /auctions/new
  def new
    @auction = Auction.new
  end

  # POST /auctions
  def create
    @auction = Auction.new(auction_params)
    @auction.seller = current_user  # Assuming seller is the logged-in user

    if @auction.save
      redirect_to @auction, notice: 'Auction was successfully created.'
    else
      render :new
    end
  end

  # GET /auctions/1
  def show
    @bid = @auction.bids.build
    @inquiry = Inquiry.new(auction: @auction)
  end

  # Additional actions (edit, update, destroy) can be implemented if needed

  private
    # Use callbacks to share common setup or constraints between actions
    def set_auction
      @auction = Auction.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def auction_params
      params.require(:auction).permit(:item_id, :start_date, :end_date, :starting_price, :bid_increment)
    end
end
