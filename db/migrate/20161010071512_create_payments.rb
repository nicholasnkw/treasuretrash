class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :braintree_payment_id
      t.string :status
      t.string :fourdigit
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
