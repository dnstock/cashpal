#-----------------------------------------------------------------------------
# Author: Dan H
# Last Modified: 5-July-2009
# COMMENTS:
#   msrp => Original (non-deal) price of deal item
#   free_shipping => Whether deal has free shipping
#-----------------------------------------------------------------------------
class AddDealField < ActiveRecord::Migration
  def self.up
    add_column :deals, :msrp, :decimal, :precision => 8, :scale => 2
    add_column :deals, :free_shipping, :boolean, :default => false
  end

  def self.down
    # no need for rollback definition
  end
end
