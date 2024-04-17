class HomeController < ApplicationController
  def index
    # require 'pry'; binding.pry
    @user = current_user
  end
end
