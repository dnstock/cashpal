#-----------------------------------------------------------------------------
# Author: Dan H
# Last Modified: 1-July-2009
# COMMENTS:
#   start_date => new field for when deal/coupon begins
#   end_date   => replaces deal/coupon expires_on field
#-----------------------------------------------------------------------------
class AddCouponDealStartEndDates < ActiveRecord::Migration
  def self.up
    add_column :deals, :start_date, :date
    add_column :coupons, :start_date, :date
    rename_column :deals, :expires_on, :end_date
    rename_column :coupons, :expires_on, :end_date
  end

  def self.down
    # no need for rollback
  end
end
