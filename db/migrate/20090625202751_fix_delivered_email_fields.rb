class FixDeliveredEmailFields < ActiveRecord::Migration
  def self.up
    change_column :delivered_emails, :email_msg, :text
    change_column :delivered_emails, :rctp_email, :string
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
