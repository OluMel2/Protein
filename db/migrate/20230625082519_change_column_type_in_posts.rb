class ChangeColumnTypeInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :calorie, :float
    change_column :posts, :protein, :float
  end
end
