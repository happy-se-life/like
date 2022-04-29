class AddAuthorIdToLikes < ActiveRecord::Migration[4.2]
    def up
        add_column :likes, :author_id, :integer, :default => nil, :after => :like_id
    end
    
    def down
        remove_column :author_id
    end
end