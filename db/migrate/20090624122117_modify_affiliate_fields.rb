#-----------------------------------------------------------------------------
# Author: Dan H
# Last Modified: 24-June-2009
# COMMENTS:
#   Removing unnecessary columns from Affiliates table.
#   See CreateAffiliates migration for comments on all Affiliate columns.
#-----------------------------------------------------------------------------
class ModifyAffiliateFields < ActiveRecord::Migration
  def self.up
    remove_column :affiliates, :is_in_addon
    remove_column :affiliates, :is_cashback_active
  end

  def self.down
    add_column :affiliates, :is_in_addon, :boolean, :default => true, :null => false
    add_column :affiliates, :is_cashback_active, :boolean, :default => true, :null => false
  end
end
