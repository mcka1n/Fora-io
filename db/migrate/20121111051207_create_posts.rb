class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
	  t.integer :board_id
	  t.integer :user_id
	  t.string  :author_name
	  t.text    :body
      t.timestamps
    end
  end
end
