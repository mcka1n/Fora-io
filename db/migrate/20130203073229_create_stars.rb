class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.integer :post_id
	  t.integer :user_id
	  t.integer  :status
      t.timestamps
    end
  end
end
