class AddRecipeIdToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :recipe_id, :integer
  end
end
