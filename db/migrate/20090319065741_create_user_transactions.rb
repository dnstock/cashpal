class CreateUserTransactions < ActiveRecord::Migration
  def self.up
    create_table :user_transactions do |t|
      t.string :action_id, :limit=>100
      t.datetime :date
      t.string :is_manual_entry, :limit=>1
      t.integer :row_id
      t.float :sale_amount
      t.string :status, :limit=>7
      t.integer :store_id
      t.float :user_commission
      t.string :user_id, :limit=>50

      t.timestamps
    end
  end

  def self.down
    drop_table :user_transactions
  end
end
