ActionMailer::Base.smtp_settings = {
    :address => ENV["SMTP_ADDRESS"],
    :port => ENV["SMTP_PORT"],
    :domain => ENV["SMTP_DOMAIN"],
    :user_name => ENV["SMTP_USER_NAME"],
    :password => ENV["SMTP_USER_PASSWORD"],
    :authentication => "plain",
    :openssl_verify_mode  => "none",
    :enable_starttls_auto => true
}
