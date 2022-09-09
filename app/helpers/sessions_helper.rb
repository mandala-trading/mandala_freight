# frozen_string_literal: true

module SessionsHelper
  def current_account
    @current_account ||= current_user&.account
  end
end
