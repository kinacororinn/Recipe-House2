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

  enum time: { "30分以内": 0, "1時間以内": 1, "1時間30分以内": 2 ,"2時間以内":3,"2時間以上":4}
end
