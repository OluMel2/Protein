class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id,      null: false
      t.integer :tag_id,       null: false
      t.string  :product_name, null: false
      t.string  :tast,         null: false
      t.integer :price,        null: false
      t.integer :net,          null: false
      t.integer :serving_size, null: false
      t.integer :calorie,     null: false
      t.integer :protein,      null: false
      t.text    :description,  null: false
      t.timestamps
    end
  end
end
