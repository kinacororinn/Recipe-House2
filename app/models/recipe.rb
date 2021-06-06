class Recipe < ApplicationRecord
  attachment :image, destroy: false
  belongs_to :user, foreign_key: "user_id"
  #has_many :favorites, dependent: :destroy
  #has_many :recipe_comments, dependent: :destroy
  belongs_to :category, foreign_key: "category_id"
end
