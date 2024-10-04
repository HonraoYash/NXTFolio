# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_workspace_session'
Rails.application.config.session_store :cookie_store, key: '_devise-omniauth_session', expire_after: 30.minutes
