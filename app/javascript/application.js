// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
// application.js

document.addEventListener('DOMContentLoaded', function() {
  const categorySelect = document.getElementById('item_category_id');
  const subcategoryField = document.getElementById('subcategory_field');

  categorySelect.addEventListener('change', function() {
    const categoryId = this.value;
    if (categoryId) {
      fetch(`/categories/${categoryId}/subcategories`)
        .then(response => response.json())
        .then(subcategories => {
          const selectSubcategory = document.createElement('select');
          selectSubcategory.setAttribute('name', 'subcategory_id');
          selectSubcategory.setAttribute('class', 'form-control');
          selectSubcategory.innerHTML = '<option value="">Select Subcategory</option>';
          subcategories.forEach(subcategory => {
            const option = document.createElement('option');
            option.setAttribute('value', subcategory.id);
            option.textContent = subcategory.name;
            selectSubcategory.appendChild(option);
          });
          subcategoryField.innerHTML = '';
          subcategoryField.appendChild(selectSubcategory);
        })
        .catch(error => console.error('Error fetching subcategories:', error));
    } else {
      subcategoryField.innerHTML = '';
    }
  });
});
