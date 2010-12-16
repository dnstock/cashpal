class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.string :browser, :limit=>100
      t.string :client_id, :limit=>20
      t.integer :id, :primary_key
      t.string :message, :limit=>4000
      t.string :msg_subject, :limit=>200
      t.datetime :msg_timestamp
      t.string :os, :limit=>100
      t.integer :rating
      t.string :user_id, :limit=>50

      t.timestamps
    end
  end

  def self.down
    drop_table :feedbacks
  end
end
