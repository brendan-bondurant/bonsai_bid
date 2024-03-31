class AddReplyToFeedbacks < ActiveRecord::Migration[7.1]
  def change
    add_column :feedbacks, :reply, :text
  end
end
