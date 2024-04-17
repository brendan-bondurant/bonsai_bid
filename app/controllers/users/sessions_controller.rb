class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_out_path_for(resource_or_scope)
    require 'pry'; binding.pry
    # Specify the path you want to redirect to after a timeout
    new_user_session_path # Typically the login path
  end
end
