json.extract! feedback, :id, :item_id, :from_user_id, :to_user_id, :rating, :comment, :feedback_time, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)
