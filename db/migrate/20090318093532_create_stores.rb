class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.string :admin_notes, :limit=>500
      t.integer :affiliate_id
      t.string :affiliate_type, :limit=>40
      t.string :category, :limit=>400
      t.string :display_commission_comment_string, :limit=>200
      t.string :display_commission_to_users, :limit=>200
      t.string :hostname, :limit=>200
      t.integer :id
      t.string :is_active, :limit=>1
      t.string :is_disabled, :limit=>1
      t.string :is_included_in_addon, :limit=>1
      t.string :name, :limit=>100

      t.timestamps
    end
  end

  def self.down
    drop_table :stores
  end
end
