class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_profile

  # GET /profile
  def show
    @user_profile = UserProfile.find(params[:id])
  end
  

  # GET /profile/edit
  def edit

  end

  # PATCH/PUT /profile
  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html { redirect_to user_profile_path(@user_profile), notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end
  

  private
    def set_user_profile
      @user_profile = current_user.user_profile
    end

    def user_profile_params
      params.require(:user_profile).permit(:name, :phone)
    end
end
