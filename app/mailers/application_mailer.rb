class ApplicationMailer < ActionMailer::Base

  default from: "brian@briandavies.me"

  layout "mailer"

  before_action :_set_app_name

  private

  def _set_app_name
    @app_name = Rails.configuration.application_display_name
  end

end
