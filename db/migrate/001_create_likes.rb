class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id, :null => false
      t.integer :like_id, :null => false
      t.string :like_type, :null => false
      t.timestamps :null => false
    end
    add_index :likes, [:like_id, :like_type]
    add_index :likes, :user_id
  end
end
