#-----------------------------------------------------------------------------
# Author: Dan H
# Last Modified: 22-June-2009
# TABLE COMMENTS:
# affiliate_id            >   FK to affiliate table
# url                     >   used to redirect users with our affiliate code
# product_image           >   url where product image is stored
# is_spotlight_deal       >   Spotlight deals get prominently featured on homepage
# created_by              >   user ID of admin who created this record
#-----------------------------------------------------------------------------

class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.integer :affiliate_id, :null => false
      t.string :url
      t.string :product_image
      t.string :title, :null => false
      t.decimal :price, :precision => 8, :scale => 2
      t.decimal :rebate, :precision => 8, :scale => 2
      t.text :description
      t.boolean :is_spotlight_deal, :default => false
      t.date :expires_on
      t.boolean :is_active, :default => true
      t.text :admin_notes
      t.integer :created_by
      t.timestamps
    end
  end

  def self.down
    drop_table :deals
  end
end
