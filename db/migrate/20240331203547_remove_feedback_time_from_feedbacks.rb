class RemoveFeedbackTimeFromFeedbacks < ActiveRecord::Migration[7.1]
  def change
    remove_column :feedbacks, :feedback_time, :datetime
  end
end
