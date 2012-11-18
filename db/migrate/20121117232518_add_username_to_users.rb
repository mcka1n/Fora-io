class AddUsernameToUsers < ActiveRecord::Migration
  def change
    #add_column :users, :username, :string
    ## Fora's hack, adding more details
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    ## Location
    add_column :users, :country, :string
    add_column :users, :state, :string
    add_column :users, :city, :string

  end
end
