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
