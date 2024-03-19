# require 'rails_helper'

# RSpec.describe FeedbacksController, type: :controller do
#   describe 'POST #create' do
#     let(:from_user) { create(:user) }
#     let(:to_user) { create(:user) }
#     let(:item) { create(:item, seller: to_user) }

#     before do
#       sign_in from_user
#     end

#     it 'allows a user to give feedback to another user' do
#       expect {
#         post :create, params: { feedback: { item_id: item.id, to_user_id: to_user.id, rating: 5, comment: "Great seller!" } }
#       }.to change(Feedback, :count).by(1)

#       feedback = Feedback.last
#       expect(feedback.to_user).to eq(to_user)
#       expect(feedback.from_user).to eq(from_user)
#       expect(feedback.rating).to eq(5)
#       expect(feedback.comment).to eq("Great seller!")
#     end
#   end
# end
