require 'rails_helper'

RSpec.describe "Users", type: :request do
  # Tests for the dashboard action
  describe 'GET /users/:id/dashboard' do
    let(:user) { create(:user) }
    let!(:item) { create(:item, seller: user) }
    let!(:watch) { create(:watchlist, user: user, item: item) }

    before do
      sign_in user
      get dashboard_user_path(user) 
    end

    it 'displays items listed by the user' do
      expect(response.body).to include(item.name)
    end

    it 'displays items in the user’s watchlist' do
      expect(response.body).to include(watch.item.name)
    end
  end

  describe 'GET /users/:id' do
    let(:user) { create(:user) }
    let(:feedback_giver) { create(:user) }
    let(:item) { create(:item, seller: user) } 
    let!(:feedback) { create(:feedback, to_user: user, from_user: feedback_giver, item: item, comment: "Very responsive.") }


    before do
      sign_in user
      get user_path(user) 
    end

    it 'shows the user name and email' do
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.email)
    end

    it 'shows feedback for the user' do
      expect(response.body).to include(feedback.comment)
    end
  end
end
