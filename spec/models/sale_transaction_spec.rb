# spec/models/transaction_spec.rb
require 'rails_helper'

RSpec.describe SaleTransaction, type: :model do
  it "is valid with valid attributes" do
    user = create(:user, id: 12)
    item = create(:item, seller: user, id: 14) 
    sale_transaction = create(:sale_transaction, item_id: item.id, seller_id: user.id)
    expect(sale_transaction).to be_valid
    expect(sale_transaction.buyer_id).to be_present
    expect(sale_transaction.seller_id).to be_present
    expect(sale_transaction.item_id).to be_present
    expect(sale_transaction.final_price).to be > 0
    expect(sale_transaction.transaction_time).to be_present
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
end
