#-----------------------------------------------------------------------------
# Author: Dan Harcsztark
# Last Modified: 7-July-2009
# COMMENTS:
#   This table is used to track views to off-site links/urls
#   It is identical to the 'clicks' table, sans 'redirect_url'
#   resource_type,id,slug => table,id,slug of record
#   failed => if the given url was not associated with a valid redirect link
#-----------------------------------------------------------------------------
class CreateViews < ActiveRecord::Migration
  def self.up
    create_table :views do |t|
      t.string :resource_type
      t.integer :resource_id
      t.string :resource_slug
      t.integer :user_id
      t.string :ip
      t.string :referer
      t.string :user_agent
      t.string :request_uri
      t.boolean :failed, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :views
  end
end
