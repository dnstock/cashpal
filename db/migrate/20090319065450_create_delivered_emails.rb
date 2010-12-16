class CreateDeliveredEmails < ActiveRecord::Migration
  def self.up
    create_table :delivered_emails do |t|
      t.datetime :email_attempt_ts
      t.string :email_msg, :limit=>2000
      t.string :rctp_email, :limit=>100
      t.integer :row_id

      t.timestamps
    end
  end

  def self.down
    drop_table :delivered_emails
  end
end
