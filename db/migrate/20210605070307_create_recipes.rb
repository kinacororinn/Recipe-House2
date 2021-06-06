class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :category_id
      t.integer :time
      t.string :image_id
      t.string :title
      t.text :component
      t.text :explanation

      t.timestamps
    end
  end
end
