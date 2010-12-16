class CreatePaymentRequests < ActiveRecord::Migration
  def self.up
    create_table :payment_requests do |t|
      t.float :amount
      t.string :is_payment_complete, :limit=>1
      t.string :payment_email, :limit=>250
      t.string :payment_provider, :limit=>200
      t.integer :payment_provider_transaction_id
      t.integer :row_id
      t.string :user_id, :limit=>50

      t.timestamps
    end
  end

  def self.down
    drop_table :payment_requests
  end
end
