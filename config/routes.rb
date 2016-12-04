Rails.application.routes.draw do
  use_doorkeeper

  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
  end if Rails.env.production? || Rails.env.staging?
  mount Sidekiq::Web => '/sidekiq'

  namespace :v1 do
    jsonapi_resources :user_password_reset_requests
    jsonapi_resources :users
  end
end
