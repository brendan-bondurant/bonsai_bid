class AddBonsaiCategories < ActiveRecord::Migration[7.1]
      def up
        ActiveRecord::Base.transaction do
          # Add top-level categories
          bonsai_essentials = add_category('Bonsai Essentials')
          plant = add_category('Plant')
          container = add_category('Container')
    
          # Add sub-categories
          add_category('Soil', bonsai_essentials.id)
          add_category('Wire', bonsai_essentials.id)
          add_category('Fertilizers/Supplements', bonsai_essentials.id)
          add_category('Tools', bonsai_essentials.id)
          add_category('Books', bonsai_essentials.id)
    
          # Add plant sub-categories
          deciduous = add_category('Deciduous', plant.id)
          coniferous = add_category('Coniferous', plant.id)
          tropical = add_category('Tropical', plant.id)
    
          add_category('Species', deciduous.id)
          add_category('Stage', deciduous.id)
          add_category('Species', coniferous.id)
          add_category('Stage', coniferous.id)
          add_category('Species', tropical.id)
          add_category('Stage', tropical.id)
    
          glazed = add_category('Glazed', container.id)
          unglazed = add_category('Unglazed', container.id)
    
          # Add container details
          add_category('Handmade', glazed.id)
          add_category('Vintage', glazed.id)
          add_category('Production', glazed.id)
          add_category('Handmade', unglazed.id)
          add_category('Vintage', unglazed.id)
          add_category('Production', unglazed.id)
          # ... repeat for unglazed ...
    
          # If we reach this point without an exception being raised,
          # ActiveRecord will commit the transaction
        end
      end
    
      def down
        # In the down method, you would reverse the order of creation
        # to remove the categories if needed.
        # Please note that this would need to be adjusted if categories
        # have dependencies or if you allow for categories to have items.
      end
    
      private
    
      def add_category(name, parent_id = nil)
        Category.create!(name: name, parent_id: parent_id)
      rescue ActiveRecord::RecordInvalid => e
        # If there's an error creating a category, we log the error
        # and raise the exception again to ensure the transaction is rolled back.
        Rails.logger.error "Failed to create category #{name}: #{e.message}"
        raise
      end
    end
