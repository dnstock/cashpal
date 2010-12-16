class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.integer :id
      t.string :link_image_or_text, :limit=>4000
      t.string :link_type, :limit=>100
      t.string :link_url, :limit=>4000
      t.integer :store_id

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
