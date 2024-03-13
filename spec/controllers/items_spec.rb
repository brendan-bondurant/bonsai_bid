require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { FactoryBot.create(:user) }
  let(:invalid_attributes) { { name: '', description: '', starting_price: nil } }
  let(:valid_attributes) do
    category = create(:category)
    starting_price = Faker::Commerce.price(range: 0..100.0, as_string: true)
    {
      category_id: category.id,
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      starting_price: starting_price,
      current_price: starting_price,
      buy_it_now_price: Faker::Commerce.price(range: 0..200.0, as_string: true), 
      start_date: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now),    
      seller_id: user.id,
      status: :listed,
      end_date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 10)
    }
  end
  
  let(:item) { FactoryBot.create(:item, seller: user) }

  before { sign_in user }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, params: { item: valid_attributes }
        }.to change(Item, :count).by(1)
      end

      it "redirects to the created item" do
        post :create, params: { item: valid_attributes }
        expect(response).to redirect_to(item_url(Item.last))
      end
    end

    context "with invalid params" do
      it "does not create a new Item" do
        expect {
          post :create, params: { item: invalid_attributes }
        }.to_not change(Item, :count)
      end

      it "renders the 'new' template" do
        post :create, params: { item: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) { { name: 'Updated Item Name' } }

      it "updates the requested item" do
        require 'pry'; binding.pry
        patch :update, params: { id: item.to_param, item: new_attributes }
        
        item.reload
        expect(item.name).to eq(new_attributes[:name])
      end

      it "redirects to the item" do
        patch :update, params: { id: item.to_param, item: new_attributes }
        expect(response).to redirect_to(item_url(item))
      end
    end

    context "with invalid params" do
      it "renders the 'edit' template" do
        patch :update, params: { id: item.to_param, item: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested item" do
      item # Ensure the item exists before we try to delete it
      expect {
        delete :destroy, params: { id: item.to_param }
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      delete :destroy, params: { id: item.to_param }
      expect(response).to redirect_to(items_url)
    end
  end
end
