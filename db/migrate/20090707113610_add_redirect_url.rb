#-----------------------------------------------------------------------------
# Author: Dan Harcsztark
# Last Modified: 7-July-2009
# COMMENTS:
#   Normalize the names of table fields
#   BOTH OF THESE FIELDS ARE TAKEN FROM THE AFFILIATE NETWORK SITE
#   link_redirect    => link to redirect user to
#   link_destination => url of destination page for redirect link
#-----------------------------------------------------------------------------
class AddRedirectUrl < ActiveRecord::Migration
  def self.up
    remove_column :affiliates, :affiliate_code
    rename_column :affiliates, :redirect_link, :link_redirect
    rename_column :deals, :url, :link_redirect
    rename_column :coupons, :url, :link_redirect
    add_column :deals, :link_destination, :string
    add_column :coupons, :link_destination, :string
  end

  def self.down
    add_column :affiliates, :affiliate_code, :string
    rename_column :affiliates, :link_redirect, :redirect_link
    rename_column :deals, :link_redirect, :url
    rename_column :coupons, :link_redirect, :url
    remove_column :deals, :link_destination
    remove_column :coupons, :link_destination
  end
end
