class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :posting, index: true, foreign_key: true
      t.boolean :status
      t.boolean :success

      t.timestamps null: false
    end
  end
end
