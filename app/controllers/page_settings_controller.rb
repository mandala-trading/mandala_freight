# frozen_string_literal: true

class PageSettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
    page_setting
  end

  def update
    if page_setting.update(page_items: page_items_params, column_settings: column_settings_params)
      redirect_to redirection_url, flash: { success: t("flash_messages.updated", name: "Page setting") }
    else
      render :edit
    end
  end

  private

  def page_setting
    @page_setting ||= current_user.page_settings.find(params[:id])
  end

  def redirection_url
    public_send("#{page_setting.module_name}_path")
  end

  def page_items_params
    params[:page_setting][:page_items]
  end

  def column_settings_params
    { off_columns: page_setting.index_columns.keys.map(&:to_s) - params[:page_setting][:off_columns] }
  end
end
