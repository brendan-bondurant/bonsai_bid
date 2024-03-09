class SearchController < ApplicationController
  def index
    @search_term = params[:search].downcase
    @results = Item.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{@search_term}%", "%#{@search_term}%") 
  end
end
