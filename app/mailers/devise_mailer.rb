# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  default from: ENV.fetch("EMAIL_SENDER", nil)
  layout "mailer"
end
