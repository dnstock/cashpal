#-----------------------------------------------------------------------------
# Author: Dan H
# TABLE COMMENTS:
# network_id                   >   FK to network table
# code                         >   our affiliate code/id
# redirect_link                >   RENAMED TO 'link_redirect'. Used to redirect user to site via our affiliate code
# commission_from_affiliate    >   the commission we receive
# commission_to_user           >   the commission we pay off as cash back to members
# created_by                   >   user ID of admin who created this record
# is_popular                   >   cycle in "Popular Stores" on Cash Back Shopping page?
# is_active                    >   enable/disable from appearing in site/addon + all cashback functionality
# is_in_addon                  >   DEPRECATED. Removed via subsequent migration.
# is_cashback_active           >   DEPRECATED. Removed via subsequent migration.
#-----------------------------------------------------------------------------

class CreateAffiliates < ActiveRecord::Migration
  def self.up
    create_table :affiliates do |t|
      t.references :network_id
      t.string :affiliate_code
      t.string :name, :null => false
      t.string :root_url, :null => false
      t.string :redirect_link
      t.string :logo_filename
      t.text :description
      t.decimal :commission_from_affiliate, :precision => 5, :scale => 2, :null => false
      t.decimal :cashback_to_user, :precision => 5, :scale => 2, :null => false
      t.boolean :is_cashback_active, :default => true, :null => false
      t.text :cashback_terms
      t.boolean :is_popular, :default => false, :null => false
      t.boolean :is_active, :default => true, :null => false
      t.boolean :is_in_addon, :default => true, :null => false
      t.text :admin_notes
      t.integer :created_by
      t.timestamps
    end
  end

  def self.down
    drop_table :affiliates
  end
end
