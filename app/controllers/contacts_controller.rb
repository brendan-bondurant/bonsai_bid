class ContactsController < ApplicationController
  def new
  end

  def create
    flash[:notice] = 'Your inquiry has been sent.'
    redirect_to contact_page_path
  end
end
