class AddAvatarsToPostings < ActiveRecord::Migration
  def change
    add_column :postings, :avatars, :json
  end
end
