class CreateNetworks < ActiveRecord::Migration
  def self.up
    create_table :networks do |t|
      t.string :name, :null => false
      t.string :url, :null => false
      t.text :admin_notes
      t.integer :created_by

      t.timestamps
    end
  end

  def self.down
    drop_table :networks
  end
end
