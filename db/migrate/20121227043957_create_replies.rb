class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :comment_id
	  t.integer :user_id
	  t.text    :body
	  t.integer :parent_reply_id	
      t.timestamps
    end
  end
end
