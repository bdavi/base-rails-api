redis_url = ENV["REDIS_URL"] || "redis://localhost:6379"

redis_config = {
  url: redis_url,
  namespace: Rails.application.class.parent_name.underscore.dasherize + "-" + Rails.env
}

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
