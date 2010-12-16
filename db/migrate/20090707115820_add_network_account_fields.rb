#-----------------------------------------------------------------------------
# Author: Dan Harcsztark
# Last Modified: 7-July-2009
# COMMENTS:
#   Adding some account info, for our reference
#-----------------------------------------------------------------------------
class AddNetworkAccountFields < ActiveRecord::Migration
  def self.up
    add_column :networks, :account_username, :string
    add_column :networks, :account_email, :string
    add_column :networks, :account_id, :string
  end

  def self.down
    remove_column :networks, :account_username
    remove_column :networks, :account_email
    remove_column :networks, :account_id
  end
end
