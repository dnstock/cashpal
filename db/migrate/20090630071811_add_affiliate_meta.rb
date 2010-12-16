#-----------------------------------------------------------------------------
# Author: Dan H
# Last Modified: 29-June-2009
# COMMENTS:
#   page_title & page_h1 => DEPRICATED. Affilate page titles and H1 tags are now dynamically set
#   meta_description & meta_keywords => Optional. If entered will insert in appropriate place.
#-----------------------------------------------------------------------------
class AddAffiliateMeta < ActiveRecord::Migration
  def self.up
    add_column :affiliates, :page_title, :string
    add_column :affiliates, :page_h1, :string
    add_column :affiliates, :meta_description, :string
    add_column :affiliates, :meta_keywords, :string
  end

  def self.down
    # no need for rollback definition
  end
end
