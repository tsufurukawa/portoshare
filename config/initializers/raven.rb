require 'raven'

Raven.configure do |config|
  config.dsn = Figaro.env.SENTRY_DSN if Rails.env.production?
end