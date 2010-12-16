#-----------------------------------------------------------------------------
# Author: Dan Harcsztark
# Last Modified: 7-July-2009
# COMMENTS:
#   The 'track_clicks' table has been replaced by the 'clicks' table
#   The 'views' table will be created when necessary
#-----------------------------------------------------------------------------
class RenameTrackerTables < ActiveRecord::Migration
  def self.up
    drop_table :track_clicks
    drop_table :track_views
    rename_table :track_downloads, :downloads
  end

  def self.down
    # no need for rollback, above tables were never implemented
  end
end
