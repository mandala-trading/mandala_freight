# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, only: :dashboard
  before_action { active_sidebar_item_option("dashboard") }

  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      redirect_to new_user_session_path
    end
  end

  def dashboard; end
end
