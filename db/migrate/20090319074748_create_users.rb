class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :login_count
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
      t.string :email, :limit=>250
      t.integer :id
      t.string :is_site_admin, :limit=>1
      t.boolean :isEmailValid
      t.string :payment_email, :limit=>250
      t.string :show_balance_info_in_addon, :limit=>1

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
