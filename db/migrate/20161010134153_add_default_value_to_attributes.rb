class AddDefaultValueToAttributes < ActiveRecord::Migration
  
  def up 
    change_column :transactions, :success, :boolean, default: false
    change_column :transactions, :status, :boolean, default: false
  end

  def down 
    change_column :transactions, :success, :boolean
    change_column :transactions, :status, :boolean
  end


end



