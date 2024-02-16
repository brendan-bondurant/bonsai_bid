json.extract! item, :id, :seller_id, :category_id, :name, :description, :images, :starting_price, :current_price, :buy_it_now_price, :start_date, :end_date, :status, :created_at, :updated_at
json.url item_url(item, format: :json)
