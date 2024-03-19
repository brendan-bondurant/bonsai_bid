# require 'rails_helper'

# RSpec.describe UsersController, type: :controller do
#   describe 'GET #dashboard' do
#     let(:user) { create(:user) }
#     let!(:item) { create(:item, seller: user) }
#     let!(:watch) { create(:watchlist, user: user, item: item) }

#     before do
#       sign_in user
#       get :dashboard
#     end

#     it 'assigns @items to include items listed by the user' do
#       expect(assigns(:items)).to include(item)
#     end

#     it 'assigns watch to include items watched by the user' do
#       expect(assigns(:watchlists)).to include(watch)
#     end
#   end

#   describe 'GET #show' do
#     let(:user) { create(:user) }
#     let(:feedback_giver) { create(:user) }
#     let!(:feedback) { create(:feedback, to_user: user, from_user: feedback_giver, comment: "Very responsive.") }

#     before do
#       get :show, params: { id: user.id }
#     end

#     it 'shows the user name and email' do
#       expect(response.body).to include(user.name)
#       expect(response.body).to include(user.email)
#     end

#     it 'shows feedback for the user' do
#       expect(response.body).to include(feedback.comment)
#     end
#   end
# end
