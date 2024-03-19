# require 'rails_helper'

# RSpec.describe WatchlistsController, type: :controller do
#   describe 'POST #create' do
#     let(:user) { create(:user) }
#     let(:item) { create(:item) }

#     before do
#       sign_in user
#     end

#     it 'allows a user to favorite an item' do
#       expect {
#         post :create, params: { item_id: item.id }
#       }.to change(Favorite, :count).by(1)

#       expect(Favorite.last.item).to eq(item)
#       expect(Favorite.last.user).to eq(user)
#     end
#   end
# end
