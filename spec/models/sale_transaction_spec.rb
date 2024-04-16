# spec/models/transaction_spec.rb
require 'rails_helper'

RSpec.describe SaleTransaction, type: :model do
  it "is valid with valid attributes" do
    user = create(:user)
    item = create(:item, seller: user) 
    sale_transaction = create(:sale_transaction, item_id: item.id, seller_id: user.id)
    expect(sale_transaction).to be_valid
    expect(sale_transaction.buyer_id).to be_present
    expect(sale_transaction.seller_id).to be_present
    expect(sale_transaction.item_id).to be_present
    expect(sale_transaction.final_price).to be > 0
  end

  it "is not valid without a buyer" do
    
    sale_transaction = build(:sale_transaction, buyer_id: nil)
    expect(sale_transaction).not_to be_valid
  end

  it "is not valid without a seller" do
    sale_transaction = build(:sale_transaction, seller_id: nil)
    expect(sale_transaction).not_to be_valid
  end

  it "is not valid without an item" do
    sale_transaction = build(:sale_transaction, item_id: nil)
    expect(sale_transaction).not_to be_valid
  end

  it "is not valid without a final price" do
    sale_transaction = build(:sale_transaction, final_price: nil)
    expect(sale_transaction).not_to be_valid
  end
  
  it 'defines payment statuses correctly' do
    user = create(:user)
    item = create(:item, seller: user) 
    sale_transaction = create(:sale_transaction, item_id: item.id, seller_id: user.id)
    expect(described_class.payment_statuses).to eq({"incomplete" => 0, "pending" => 1, "complete" => 2})
  end
  
  it 'defaults to incomplete' do
    user = create(:user)
    user2 = create(:user)
    item = create(:item, seller: user) 
    sale_transaction = SaleTransaction.create!(item_id: item.id, seller_id: user.id, buyer_id: user2.id, final_price: 300.00)
    expect(sale_transaction.payment_status).to eq('incomplete')
  end
  
  it 'can be set to pending' do
    user = create(:user)
    item = create(:item, seller: user) 
    sale_transaction = create(:sale_transaction, item_id: item.id, seller_id: user.id)
    sale_transaction.pending!
    expect(sale_transaction.payment_status).to eq('pending')
  end
  
  it 'can be set to complete' do
    user = create(:user)
    item = create(:item, seller: user) 
    sale_transaction = create(:sale_transaction, item_id: item.id, seller_id: user.id)
    sale_transaction.complete!
    expect(sale_transaction.payment_status).to eq('complete')
  end
end
