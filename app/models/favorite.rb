class Favorite < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  belongs_to :recipe_id, foreign_key: "recipe_id"
end
