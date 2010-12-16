# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090707130005) do

  create_table "affiliates", :force => true do |t|
    t.integer  "network_id"
    t.string   "name",                                                                       :null => false
    t.string   "root_url",                                                                   :null => false
    t.string   "link_redirect"
    t.string   "logo_filename"
    t.text     "description"
    t.decimal  "commission_from_affiliate", :precision => 5, :scale => 2
    t.decimal  "cashback_to_user",          :precision => 5, :scale => 2
    t.text     "cashback_terms"
    t.boolean  "is_popular",                                              :default => false, :null => false
    t.boolean  "is_active",                                               :default => true,  :null => false
    t.text     "admin_notes"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "page_title"
    t.string   "page_h1"
    t.string   "meta_description"
    t.string   "meta_keywords"
  end

  create_table "clicks", :force => true do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "resource_slug"
    t.string   "redirect_url"
    t.integer  "user_id"
    t.string   "ip"
    t.string   "referer"
    t.string   "user_agent"
    t.string   "request_uri"
    t.boolean  "failed",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_installations", :primary_key => "row_id", :force => true do |t|
    t.string    "user_id",   :limit => 100, :null => false
    t.string    "client_id", :limit => 20,  :null => false
    t.timestamp "ts",                       :null => false
  end

  add_index "client_installations", ["user_id", "client_id"], :name => "user_id", :unique => true

  create_table "commission_rates", :id => false, :force => true do |t|
    t.integer "COMMRATE_ROW_ID",                                      :default => 0, :null => false
    t.integer "JVY_PROJECT_STORES_ID",                                               :null => false
    t.string  "COMMRATE_IS_COMMISSION_PERCENT",       :limit => 1,                   :null => false
    t.float   "COMMRATE_BEGIN_TOTAL_COMMISSION_RATE",                                :null => false
    t.float   "COMMRATE_END_TOTAL_COMMISSION_RATE",                                  :null => false
    t.float   "COMMRATE_PAYOUT_TO_USER",                                             :null => false
    t.string  "COMMRATE_NOTES",                       :limit => 2000
  end

  create_table "contacts", :force => true do |t|
    t.string   "origin"
    t.string   "client_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.string   "ip"
    t.string   "referer"
    t.string   "user_agent",  :null => false
    t.string   "request_uri", :null => false
    t.text     "admin_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", :force => true do |t|
    t.integer  "affiliate_id",                         :null => false
    t.string   "title",                                :null => false
    t.string   "coupon_code"
    t.text     "description"
    t.date     "end_date"
    t.string   "link_redirect"
    t.boolean  "is_stackable",      :default => false
    t.boolean  "is_spotlight_deal", :default => false
    t.boolean  "is_active",         :default => true
    t.text     "admin_notes"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.string   "link_destination"
  end

  create_table "deals", :force => true do |t|
    t.integer  "affiliate_id",                                                       :null => false
    t.string   "link_redirect"
    t.string   "product_image"
    t.string   "title",                                                              :null => false
    t.decimal  "price",             :precision => 8, :scale => 2
    t.decimal  "rebate",            :precision => 8, :scale => 2
    t.text     "description"
    t.boolean  "is_spotlight_deal",                               :default => false
    t.date     "end_date"
    t.boolean  "is_active",                                       :default => true
    t.text     "admin_notes"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.decimal  "msrp",              :precision => 8, :scale => 2
    t.boolean  "free_shipping",                                   :default => false
    t.string   "link_destination"
  end

  create_table "delivered_emails", :primary_key => "row_id", :force => true do |t|
    t.timestamp "email_attempt_ts", :null => false
    t.string    "rctp_email",       :null => false
    t.text      "email_msg",        :null => false
  end

  create_table "downloads", :force => true do |t|
    t.string   "ip"
    t.string   "host"
    t.string   "username"
    t.string   "url"
    t.string   "referer"
    t.string   "download_link"
    t.string   "is_already_installed_on_this_browser"
    t.string   "filename"
    t.string   "cao_version"
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", :force => true do |t|
    t.string    "user_id",       :limit => 50
    t.timestamp "msg_timestamp",                 :null => false
    t.string    "msg_subject",   :limit => 200
    t.integer   "rating"
    t.string    "message",       :limit => 4000
    t.string    "os",            :limit => 100
    t.string    "browser",       :limit => 100
    t.string    "client_id",     :limit => 20
  end

  add_index "feedbacks", ["user_id"], :name => "fk_users"

  create_table "links", :force => true do |t|
    t.integer "store_id",                                                    :null => false
    t.string  "link_type",          :limit => 100,  :default => "STORELINK", :null => false
    t.string  "link_url",           :limit => 4000,                          :null => false
    t.string  "link_image_or_text", :limit => 4000,                          :null => false
  end

  add_index "links", ["store_id", "link_type"], :name => "store_id", :unique => true

  create_table "merchants", :id => false, :force => true do |t|
    t.string "merchantName",        :limit => 100,                  :null => false
    t.string "searchString",        :limit => 200
    t.string "trackingRedirectUrl", :limit => 4000,                 :null => false
    t.string "affiliateType",       :limit => 40
    t.string "isTrackedInAddon",    :limit => 1,    :default => "", :null => false
  end

  create_table "networks", :force => true do |t|
    t.string   "name",             :null => false
    t.string   "url",              :null => false
    t.text     "admin_notes"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_username"
    t.string   "account_email"
    t.string   "account_id"
  end

  create_table "payment_requests", :primary_key => "row_id", :force => true do |t|
    t.string  "user_id",                         :limit => 50,                   :null => false
    t.string  "payment_email",                   :limit => 250,                  :null => false
    t.float   "amount",                                                          :null => false
    t.integer "payment_provider_transaction_id"
    t.string  "is_payment_complete",             :limit => 1,   :default => "N", :null => false
    t.string  "payment_provider",                :limit => 200,                  :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sitemap_settings", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "xml_location"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sitemap_static_links", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.float    "priority"
    t.string   "frequency"
    t.string   "section"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sitemap_widgets", :force => true do |t|
    t.string   "widget_model"
    t.string   "index_named_route"
    t.string   "frequency_index"
    t.string   "frequency_show"
    t.float    "priority"
    t.string   "custom_finder"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_name_and_sluggable_type_and_scope_and_sequence", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "store_link_view", :force => true do |t|
    t.string  "name",               :limit => 100,                           :null => false
    t.integer "affiliate_id",       :limit => 8
    t.integer "links_id",                           :default => 0,           :null => false
    t.string  "link_url",           :limit => 4000,                          :null => false
    t.string  "link_image_or_text", :limit => 4000,                          :null => false
    t.string  "hostname",           :limit => 200
    t.string  "link_type",          :limit => 100,  :default => "STORELINK", :null => false
  end

  create_table "stores", :force => true do |t|
    t.string  "name",                              :limit => 100,                  :null => false
    t.string  "category",                          :limit => 400, :default => " ", :null => false
    t.string  "affiliate_type",                    :limit => 40
    t.integer "affiliate_id",                      :limit => 8
    t.string  "is_active",                         :limit => 1
    t.string  "hostname",                          :limit => 200
    t.string  "is_disabled",                       :limit => 1,   :default => "N", :null => false
    t.string  "display_commission_to_users",       :limit => 200
    t.string  "display_commission_comment_string", :limit => 200
    t.string  "is_included_in_addon",              :limit => 1,   :default => "Y", :null => false
    t.string  "admin_notes",                       :limit => 500
    t.integer "tester",                                                            :null => false
  end

  add_index "stores", ["affiliate_id", "affiliate_type"], :name => "affiliate_id", :unique => true
  add_index "stores", ["name"], :name => "name", :unique => true

  create_table "stores_bak", :force => true do |t|
    t.string  "name",                              :limit => 100,                   :null => false
    t.string  "info_link",                         :limit => 2000
    t.string  "category",                          :limit => 400,  :default => " ", :null => false
    t.string  "affiliate_type",                    :limit => 40
    t.integer "affiliate_id",                      :limit => 8
    t.string  "is_active",                         :limit => 1
    t.string  "hostname",                          :limit => 200
    t.string  "is_disabled",                       :limit => 1,    :default => "N", :null => false
    t.string  "display_commission_to_users",       :limit => 20
    t.string  "display_commission_comment_string", :limit => 200
    t.string  "is_tracked_in_addon",               :limit => 1,    :default => "Y", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_transactions", :primary_key => "row_id", :force => true do |t|
    t.string   "status",          :limit => 7,   :default => "",  :null => false
    t.string   "user_id",         :limit => 30,  :default => "",  :null => false
    t.datetime "date",                                            :null => false
    t.integer  "store_id",                                        :null => false
    t.string   "action_id",       :limit => 100, :default => "0", :null => false
    t.float    "user_commission",                :default => 0.0, :null => false
    t.float    "sale_amount",                    :default => 0.0, :null => false
    t.string   "is_manual_entry", :limit => 1,   :default => "Y", :null => false
  end

  add_index "user_transactions", ["action_id", "store_id"], :name => "action_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "email",                      :limit => 250
    t.string   "is_site_admin",              :limit => 1
    t.boolean  "isEmailValid"
    t.string   "payment_email",              :limit => 250
    t.string   "show_balance_info_in_addon", :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token",                          :default => "", :null => false
  end

  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

  create_table "users_old", :force => true do |t|
    t.string  "user_id",                    :limit => 50,                   :null => false
    t.string  "pwd",                        :limit => 100,                  :null => false
    t.string  "email",                      :limit => 250
    t.integer "isEmailValid",               :limit => 1
    t.string  "payment_email",              :limit => 250
    t.string  "show_balance_info_in_addon", :limit => 1,   :default => "Y", :null => false
    t.string  "is_site_admin",              :limit => 1,   :default => "N", :null => false
  end

  add_index "users_old", ["email"], :name => "email", :unique => true

  create_table "view_user_commission_summary", :id => false, :force => true do |t|
    t.string "user_id",   :limit => 50, :default => "", :null => false
    t.float  "pending"
    t.float  "earned"
    t.float  "available"
    t.float  "paid"
  end

  create_table "view_user_commission_summary_raw", :id => false, :force => true do |t|
    t.string "user_id",   :limit => 50, :default => "", :null => false
    t.float  "pending"
    t.float  "earned"
    t.float  "available"
    t.float  "paid"
  end

  create_table "views", :force => true do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "resource_slug"
    t.integer  "user_id"
    t.string   "ip"
    t.string   "referer"
    t.string   "user_agent"
    t.string   "request_uri"
    t.boolean  "failed",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
