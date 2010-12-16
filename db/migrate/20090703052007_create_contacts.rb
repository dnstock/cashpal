#-----------------------------------------------------------------------------
# Author: Dan H
# Last Modified: 3-July-2009
# COMMENTS:
#   origin    => Originating location of form. Ex: 'website', 'plugin'
#   client_id => Addon installation ID. If sent from the addon.
#   user_id   => automatically recorded if user is logged in
#-----------------------------------------------------------------------------
class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :origin
      t.string :client_id
      t.integer :user_id
      t.string :name
      t.string :email
      t.string :subject
      t.text :body
      t.string :ip
      t.string :referer
      t.string :user_agent
      t.string :request_uri
      t.text :admin_notes
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
