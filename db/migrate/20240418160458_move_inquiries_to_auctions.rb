class MoveInquiriesToAuctions < ActiveRecord::Migration[7.1]
  def change
    remove_reference :inquiries, :item, index: true
    add_reference :inquiries, :auction, index: true
  end
end
