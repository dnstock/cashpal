# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_website_session',
  :secret      => 'f514013d3ca468ee7b2390782d6e806048d2e3f99773aba1462688cf03e15171b147f7f3fde1e84cf206c700a86c5f9b216ae5747f49d0ca2f50748f499d6543'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
