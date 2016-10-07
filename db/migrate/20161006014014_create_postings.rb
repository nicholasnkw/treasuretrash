class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.string :title
      t.text :description
      t.string :condition
      t.string :category
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.boolean :availability, default: :true

      t.timestamps null: false
    end
  end
end
