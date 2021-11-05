class AddUseridToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :userid, :string
  end
end
