class Favorite < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  belongs_to :recipe
  validates :recipe_id, uniqueness: { scope: :user_id }
end
