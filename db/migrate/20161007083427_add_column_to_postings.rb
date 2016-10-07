class AddColumnToPostings < ActiveRecord::Migration
  def change
  	add_reference :postings, :user, index: true
  end
end
