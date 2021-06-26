class Recipe < ApplicationRecord
  attachment :image, destroy: false
  belongs_to :user, foreign_key: "user_id"
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :recipe_comments, dependent: :destroy
  belongs_to :category, foreign_key: "category_id"

  def favorited_by?(user)
   favorites.where(user_id: user.id).exists?
  end

  validates :image, :title, :component, :explanation, :time, :category_id, presence: true

end
