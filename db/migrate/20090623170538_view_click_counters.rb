#-----------------------------------------------------------------------------
# Author: Dan H
# Last Modified: 23-June-2009
# COMMENTS:
#   Adding counters for tracking popularity of stores, deals, coupons (s/d/c)
#   counter_views => counts times s/d/c page on cao.com has been viewed
#   counter_clicks => counts times user clicked s/d/c link and was redirects
#   counter_views is not implemented for deals or coupons, only for affiliates
#   Example:
#    12 users visit cao's Buy.com page
#     4 users click on link to Buy.com website
#     6 users click on '20% off' coupon
#     9 of those users click '$200 netbook' deal
#     Results:
#     Buy.com's counter_views will increase by 12 in affiliates table
#               counter_clicks will increase by 4 in affiliates table
#     coupon's  counter_clicks will increase by 6 in coupons table
#     deal's    counter_clicks will increase by 9 in the deals table
#-----------------------------------------------------------------------------
class ViewClickCounters < ActiveRecord::Migration
  def self.up
    add_column :affiliates, :counter_views, :integer, :null => false, :default => 0
    add_column :affiliates, :counter_clicks, :integer, :null => false, :default => 0
    add_column :deals, :counter_views, :integer, :null => false, :default => 0
    add_column :deals, :counter_clicks, :integer, :null => false, :default => 0
    add_column :coupons, :counter_views, :integer, :null => false, :default => 0
    add_column :coupons, :counter_clicks, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :affiliates, :counter_views
    remove_column :affiliates, :counter_clicks
    remove_column :deals, :counter_views
    remove_column :deals, :counter_clicks
    remove_column :coupons, :counter_views
    remove_column :coupons, :counter_clicks
  end
end
