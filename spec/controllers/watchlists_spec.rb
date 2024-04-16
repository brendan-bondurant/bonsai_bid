# require 'rails_helper'

# RSpec.describe WatchlistsController, type: :controller do
#   describe 'POST #create' do
#     let(:user) { create(:user) }
#     let(:other_user) { create(:user) }
#     let(:item) { create(:item, seller: other_user) }

#     before do
#       sign_in user
#     end

#     it 'allows a user to watch an item' do
#       expect {
#         post :create, params: { item_id: item.id }
#       }.to change(Watchlist, :count).by(1)

#       expect(Watchlist.last.item).to eq(item)
#       expect(Watchlist.last.user).to eq(user)
#     end
#   end
# end
