#-----------------------------------------------------------------------------
# Author: Dan H
# Last Modified: 22-June-2009
# TABLE COMMENTS:
# affiliate_id            >   FK to affiliate table
# url                     >   used to redirect users with our affiliate code
# is_stackable            >   if the coupon is stackable
# is_spotlight_deal       >   Spotlight deals get prominently featured on homepage
# created_by              >   user ID of admin who created this record
#-----------------------------------------------------------------------------

class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.integer :affiliate_id, :null => false
      t.string :title, :null => false
      t.string :coupon_code
      t.text :description
      t.date :expires_on
      t.string :url
      t.boolean :is_stackable, :default => false
      t.boolean :is_spotlight_deal, :default => false
      t.boolean :is_active, :default => true
      t.text :admin_notes
      t.integer :created_by
      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
