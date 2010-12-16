#-----------------------------------------------------------------------------
# Author: Dan H
# Last Modified: 29-June-2009
# COMMENTS:
#   These were added in the ViewClickCounters migration.
#   They were never never implemented, so no rollback needs to be defined.
#   They were replaced with tracker tables via the CreateTrackers migration.
#-----------------------------------------------------------------------------
class RemoveCounters < ActiveRecord::Migration
  def self.up
    remove_column :affiliates, :counter_views
    remove_column :affiliates, :counter_clicks
    remove_column :deals, :counter_views
    remove_column :deals, :counter_clicks
    remove_column :coupons, :counter_views
    remove_column :coupons, :counter_clicks
  end

  def self.down
    # no rollback necessary, they were never implemented (see comments above)
  end
end
