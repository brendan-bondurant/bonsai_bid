# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Top-level Categories
# bonsai_essentials = Category.find_or_create_by!(name: "Bonsai Essentials", description: "All essentials for Bonsai care")
# plant = Category.find_or_create_by!(name: "Plant", description: "Different types of plants")
# container = Category.find_or_create_by!(name: "Container", description: "Containers for plants")

# # Subcategories for Bonsai Essentials
# ['Soil', 'Fertilizers/Supplements', 'Wire', 'Tools', 'Books'].each do |subcat|
#   Category.find_or_create_by!(name: subcat, description: "#{subcat} for Bonsai Essentials", parent: bonsai_essentials)
# end

# # Subcategories for Plant and further nested categories
# ['Deciduous', 'Coniferous', 'Tropical'].each do |subcat|
#   category = Category.find_or_create_by!(name: subcat, description: "#{subcat} plants", parent: plant)
#   ['Stage', 'Species'].each do |nested_subcat|
#     Category.find_or_create_by!(name: nested_subcat, description: "#{nested_subcat} of #{subcat}", parent: category)
#   end
# end

# # Subcategories for Container and further nested categories
# ['Glazed', 'Unglazed'].each do |subcat|
#   category = Category.find_or_create_by!(name: subcat, description: "#{subcat} containers", parent: container)
#   ['Production', 'Handmade', 'Vintage', 'Sizing'].each do |nested_subcat|
#     Category.find_or_create_by!(name: nested_subcat, description: "#{nested_subcat} of #{subcat} containers", parent: category)
#   end
# end

# db/seeds.rb


# Create Categories and Subcategories
bonsai_essentials = Category.find_or_create_by!(name: "Bonsai Essentials", description: "All essentials for Bonsai care")
plant = Category.find_or_create_by!(name: "Plant", description: "Different types of plants")
container = Category.find_or_create_by!(name: "Container", description: "Containers for plants")

# Subcategories for Bonsai Essentials
['Soil', 'Fertilizers/Supplements', 'Wire', 'Tools', 'Books'].each do |subcat|
  Category.find_or_create_by!(name: subcat, description: "#{subcat} for Bonsai Essentials", parent: bonsai_essentials)
end

# Subcategories for Plant and further nested categories
['Deciduous', 'Coniferous', 'Tropical'].each do |subcat|
  category = Category.find_or_create_by!(name: subcat, description: "#{subcat} plants", parent: plant)
  ['Stage', 'Species'].each do |nested_subcat|
    Category.find_or_create_by!(name: nested_subcat, description: "#{nested_subcat} of #{subcat}", parent: category)
  end
end

# Subcategories for Container and further nested categories
['Glazed', 'Unglazed'].each do |subcat|
  category = Category.find_or_create_by!(name: subcat, description: "#{subcat} containers", parent: container)
  ['Production', 'Handmade', 'Vintage', 'Sizing'].each do |nested_subcat|
    Category.find_or_create_by!(name: nested_subcat, description: "#{nested_subcat} of #{subcat} containers", parent: category)
  end
end

# Create Users
10_000.times do
  user = User.create!(
    email: Faker::Internet.unique.email,
    password_digest: User.digest('password'),
    name: Faker::Name.name,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number
  )

  # Create Items for each User
  rand(1..5).times do
    item = Item.create!(
      seller: user,
      category: Category.order('RANDOM()').first,
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      starting_price: Faker::Commerce.price(range: 0..100.0),
      current_price: Faker::Commerce.price(range: 100.0..1000.0),
      buy_it_now_price: Faker::Commerce.price(range: 1000.0..5000.0),
      start_date: Faker::Date.backward(days: 14),
      end_date: Faker::Date.forward(days: 14)
    )

    # Create Bids for each Item
    rand(0..10).times do
      Bid.create!(
        item: item,
        bidder: User.order('RANDOM()').first,
        bid_amount: Faker::Commerce.price(range: item.starting_price..item.buy_it_now_price),
        bid_time: Faker::Time.between(from: item.start_date, to: item.end_date)
      )
    end

    # Create Feedback for each Item
    if rand(10) > 5  # Roughly 50% chance to leave feedback
      Feedback.create!(
        item: item,
        from_user: user,
        to_user: User.order('RANDOM()').first,
        rating: rand(1..5),
        comment: Faker::Lorem.sentence,
        feedback_time: Faker::Time.between(from: item.end_date, to: DateTime.now)
      )
    end

    # Create Watchlist entries
    rand(0..5).times do
      Watchlist.create!(
        user: User.order('RANDOM()').first,
        item: item
      )
    end
  end
end

puts "Seed data created."
