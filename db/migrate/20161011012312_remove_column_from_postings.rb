class RemoveColumnFromPostings < ActiveRecord::Migration
  def change
    remove_column :postings, :status
    remove_column :postings, :success
  end
end

