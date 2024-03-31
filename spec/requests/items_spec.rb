RSpec.describe 'Items', type: :request do
  describe 'GET /index' do
    let(:user) { create(:user) }
    it 'returns a list of items' do
      FactoryBot.create(:item, seller: user, name: 'Vintage Vase', description: 'A beautiful vintage vase.')
      get items_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Vintage Vase')
    end
  end
end