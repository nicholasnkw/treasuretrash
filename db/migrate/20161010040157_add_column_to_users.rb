class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :credit, :integer, :default => 100
  end
end
