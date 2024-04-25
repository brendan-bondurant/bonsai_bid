require 'rails_helper'

RSpec.describe SaleTransaction, type: :model do
  it "is valid with valid attributes" do
    user = create(:user)
    item = create(:item, seller: user) 
    auction = create(:auction, item: item, seller_id: user.id)  # Ensuring auction exists
    sale_transaction = create(:sale_transaction, auction_id: auction.id, seller_id: user.id, buyer_id: create(:user).id, final_price: 100)
    
    expect(sale_transaction).to be_valid
    expect(sale_transaction.buyer_id).to be_present
    expect(sale_transaction.seller_id).to be_present
    expect(sale_transaction.auction_id).to be_present
    expect(sale_transaction.final_price).to be > 0
  end

  it "is not valid without a buyer" do
    auction = create(:auction)
    sale_transaction = build(:sale_transaction, buyer_id: nil, auction_id: auction.id)
    expect(sale_transaction).not_to be_valid
  end

  it "is not valid without a seller" do
    auction = create(:auction)
    sale_transaction = build(:sale_transaction, seller_id: nil, auction_id: auction.id)
    expect(sale_transaction).not_to be_valid
  end

  it "is not valid without an auction" do
    sale_transaction = build(:sale_transaction, auction_id: nil)
    expect(sale_transaction).not_to be_valid
  end

  it "is not valid without a final price" do
    auction = create(:auction)
    sale_transaction = build(:sale_transaction, final_price: nil, auction_id: auction.id)
    expect(sale_transaction).not_to be_valid
  end
  
  it 'defines payment statuses correctly' do
    expect(described_class.payment_statuses).to eq({"incomplete" => 0, "pending" => 1, "complete" => 2})
  end
  
  it 'defaults to incomplete' do
    auction = create(:auction)
    sale_transaction = SaleTransaction.create!(auction_id: auction.id, seller_id: auction.seller_id, buyer_id: create(:user).id, final_price: 300.00)
    expect(sale_transaction.payment_status).to eq('incomplete')
  end
  
  it 'can be set to pending' do
    auction = create(:auction)
    sale_transaction = create(:sale_transaction, auction_id: auction.id)
    sale_transaction.pending!
    expect(sale_transaction.payment_status).to eq('pending')
  end
  
  it 'can be set to complete' do
    auction = create(:auction)
    sale_transaction = create(:sale_transaction, auction_id: auction.id)
    sale_transaction.complete!
    expect(sale_transaction.payment_status).to eq('complete')
  end
end
