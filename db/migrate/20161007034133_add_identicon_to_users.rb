class AddIdenticonToUsers < ActiveRecord::Migration
  def change
    add_column :users, :identicon, :string
  end
end
