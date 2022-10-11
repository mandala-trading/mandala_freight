# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :resolve_layout

  include SessionsHelper
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user, unless: :devise_controller?

  helper_method :page_constant

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  def page_constant
    {}
  end

  def index_path
    url_for(controller: controller_name, action: "index")
  end

  def page_setting
    @page_setting ||= current_user.find_page_setting(page_constant)
  end

  def active_sidebar_item_option(option)
    @active_sidebar_item = option
  end

  def active_sidebar_sub_item_option(option)
    @active_sidebar_sub_item = option
  end

  private

  def set_current_user
    User.current_user = current_user
  end

  def resolve_layout
    if user_signed_in?
      "application"
    else
      "basic"
    end
  end
end
