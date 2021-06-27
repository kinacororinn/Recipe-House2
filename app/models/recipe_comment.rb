class RecipeComment < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  belongs_to :recipe, foreign_key: "recipe_id"
  validates :recipe_comment,length: { maximum: 100 },presence: true
end
