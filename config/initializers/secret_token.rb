# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
ResortReservation::Application.config.secret_key_base = 
Rails.env.production? ? ENV['SESSION_SECRET'] : 'be69bd8b074812d78a98e39ce1cf0f9d962e8f6dc1c4488a192b54383e1770891303b12f88901f941757cfc899ce51a76c856f0d440ef1507612212b2e3348f6'
