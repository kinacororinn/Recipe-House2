class RecipeComment < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  belongs_to :recipe, foreign_key: "recipe_id"
end
