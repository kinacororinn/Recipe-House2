class CreateRecipeComments < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_comments do |t|
      t.integer :recipe_id
      t.string :recipe_comment

      t.timestamps
    end
  end
end
