# frozen_string_literal: true

class PageSettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
    page_setting
  end

  def update
    if page_setting.update(page_setting_params)
      redirect_to redirection_url, flash: { success: t("flash_messages.updated", name: "Page setting") }
    else
      render :edit
    end
  end

  private

  def page_setting_params
    params.require(:page_setting).permit(:page_items, :hide_deleted_records, column_settings: []).tap do |hash|
      hash[:column_settings] = { off_columns: page_setting.index_columns.keys.map(&:to_s) - hash[:column_settings] }
    end
  end

  def page_setting
    @page_setting ||= current_user.page_settings.find(params[:id])
  end

  def redirection_url
    public_send("#{page_setting.module_name}_path")
  end
end
