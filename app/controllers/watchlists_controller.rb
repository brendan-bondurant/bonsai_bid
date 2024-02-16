class WatchlistsController < ApplicationController
  before_action :set_watchlist, only: %i[ show edit update destroy ]

  # GET /watchlists or /watchlists.json
  def index
    @watchlists = Watchlist.all
  end

  # GET /watchlists/1 or /watchlists/1.json
  def show
  end

  # GET /watchlists/new
  def new
    @watchlist = Watchlist.new
  end

  # GET /watchlists/1/edit
  def edit
  end

  # POST /watchlists or /watchlists.json
  def create
    @watchlist = Watchlist.new(watchlist_params)

    respond_to do |format|
      if @watchlist.save
        format.html { redirect_to watchlist_url(@watchlist), notice: "Watchlist was successfully created." }
        format.json { render :show, status: :created, location: @watchlist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @watchlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /watchlists/1 or /watchlists/1.json
  def update
    respond_to do |format|
      if @watchlist.update(watchlist_params)
        format.html { redirect_to watchlist_url(@watchlist), notice: "Watchlist was successfully updated." }
        format.json { render :show, status: :ok, location: @watchlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @watchlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /watchlists/1 or /watchlists/1.json
  def destroy
    @watchlist.destroy!

    respond_to do |format|
      format.html { redirect_to watchlists_url, notice: "Watchlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watchlist
      @watchlist = Watchlist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def watchlist_params
      params.require(:watchlist).permit(:user_id, :item_id)
    end
end
