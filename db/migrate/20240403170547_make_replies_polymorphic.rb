class MakeRepliesPolymorphic < ActiveRecord::Migration[7.1]
  def change
    remove_reference :replies, :feedback, index: true, foreign_key: true
    add_reference :replies, :respondable, polymorphic: true, null: false, index: true
  end
end
