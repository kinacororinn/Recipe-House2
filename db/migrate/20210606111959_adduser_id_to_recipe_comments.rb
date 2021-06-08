class AdduserIdToRecipeComments < ActiveRecord::Migration[5.2]
  def change
    add_column :recipe_comments, :user_id, :integer
  end
end
