# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_one_story_session',
  :secret      => 'e63430e6493ffca8c1981c84402dcaa1ff80b3bd8d8f132a26be1a694cde74865a07d8e8c4118622cd39cdb7eb84cce6087b847ea53b84975ed2eca03b6f24b0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
