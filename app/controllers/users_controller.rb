class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update dashboard ]

  # GET /users or /users.json
  # def index
  #   @users = User.all
  # end

  # GET /users/1 or /users/1.json
  def show
    @user = current_user
  end

  def dashboard
    @watchlists = current_user.watchlist_items
  end

  def profile
    if current_user.id != params[:id]
    @other_user = User.includes(sales: :feedbacks, purchases: :feedbacks).find(params[:id])
    else
      redirect_to user_dashboard_path
    end
  end

  # GET /users/new DEVISE
  # def new
  #   @user = User.new
  # end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json DEVISE
  # def create
  #   @user = User.new(user_params)
  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to user_url(@user), notice: "Welcome! You have signed up successfully." }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def edit
    # require 'pry'; binding.pry
  end
  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # def login DEVISE
  #   user = User.find_by(email: params[:email])
  #   if user.nil?
  #     flash[:error] = "Sorry, we are unable to find a user with this e-mail. Please check credentials or create an account."
  #     redirect_to login_path
  #   elsif user.authenticate(params[:password])
  #     session[:user_id] = user.id
  #     flash[:success] = "Signed in successfully."
  #     redirect_to user_url(user), notice: "Signed in successfully."
  #   else
  #     require 'pry'; binding.pry
  #     flash[:error] = "Sorry, your credentials are bad."
  #     render :login_form
  #   end
  # end

  # DELETE /users/1 or /users/1.json DEVISE
  # def destroy
  #   @user.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: "User was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :address, :phone)
    end
end
