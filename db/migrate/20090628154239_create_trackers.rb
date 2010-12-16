#-----------------------------------------------------------------------------
# Author: Dan H
# Last Modified: 29-June-2009
# COMMENTS:
#   Tracker tables are used to track different user actions on the site
#   track_downloads:
#     Track each time a user downloads the CAO addon
#     ip, host, username => their current ip & host, and username if logged in
#     url, referer => what url they were on, the HTTP REFERER string
#     download_link => which link they used
#     filename, cao_version => info on the specific file they downloaded
#     controller, action => name of Controller and Action of the page
#   track_clicks & track_views:
#     Polymorphic tables for tracking when users click or view stores, deals, coupons
#-----------------------------------------------------------------------------
class CreateTrackers < ActiveRecord::Migration
  def self.up
    create_table :track_downloads do |t|
      t.string :ip
      t.string :host
      t.string :username
      t.string :url
      t.string :referer
      t.string :download_link
      t.string :is_already_installed_on_this_browser
      t.string :filename
      t.string :cao_version
      t.string :controller
      t.string :action
      t.timestamps
    end
    create_table :track_clicks do |t|
      t.string :ip
      t.string :host
      t.string :username
      t.string :url
      t.string :referer
      t.integer :resource_id
      t.string :resource_type
      t.timestamps
    end
    create_table :track_views do |t|
      t.string :ip
      t.string :host
      t.string :username
      t.string :url
      t.string :referer
      t.integer :resource_id
      t.string :resource_type
      t.timestamps
    end
  end

  def self.down
    drop_table :track_downloads
    drop_table :track_clicks
    drop_table :track_views
  end
end
