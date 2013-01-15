class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :board_id
	  t.integer :user_id
	  t.integer  :status
      t.timestamps
    end
  end
end
