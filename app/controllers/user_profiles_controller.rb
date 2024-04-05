class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_profile

  # GET /profile
  def show
    # Your logic here
    # Typically, you might not need a show action since the profile could be viewed on the user's account page
  end

  # GET /profile/edit
  def edit
    # Edit action for the user profile
  end

  # PATCH/PUT /profile
  def update
    require 'pry'; binding.pry
    if @user_profile.update(user_profile_params)
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      # Ensures the user can only access their own profile
      @user_profile = current_user.user_profile
    end

    # Only allow a list of trusted parameters through.
    def user_profile_params
      params.require(:user_profile).permit(:name, :phone)
    end
end
