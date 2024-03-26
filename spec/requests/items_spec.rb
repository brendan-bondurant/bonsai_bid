RSpec.describe 'Items', type: :request do
  describe 'GET /index' do
    let(:user) { create(:user, id: 778) }
    it 'returns a list of items' do
      FactoryBot.create(:item, seller: user, id: 7899, name: 'Vintage Vase', description: 'A beautiful vintage vase.')
      get items_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Vintage Vase')
    end
  end
end