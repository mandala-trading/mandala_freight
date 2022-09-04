# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("EMAIL_SENDER", nil)
  layout "mailer"
end
