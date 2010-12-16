class CreateClientInstallations < ActiveRecord::Migration
  def self.up
    create_table :client_installations do |t|
      t.column :row_id, :integer
      t.string :client_id, :limit=>20
      t.timestamp :ts
      t.string :user_id, :limit=>100

      t.timestamps
    end
  end

  def self.down
    drop_table :client_installations
  end
end
