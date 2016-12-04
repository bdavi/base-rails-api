class ApplicationMailer < ActionMailer::Base
  default from: "hello@domain.com"
  layout "mailer"
end
