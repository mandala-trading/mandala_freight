# frozen_string_literal: true

class FilterOptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @filter_option = current_user.filter_options.new(
      module_class: params[:module_class],
      module_name: params[:module_name],
      filters: params[:filters]
    )
  end

  def create
    @filter_option = current_user.filter_options.new(filter_option_params)

    if @filter_option.save
      redirect_to redirection_url, flash: { success: t("flash_messages.created", name: "Filter option") }
    else
      render :new
    end
  end

  def destroy
    filter_option.destroy
    @filter_options = current_user.find_filter_options(filter_option.page_constant)
    flash.now[:danger] = t("flash_messages.deleted", name: "Filter option")
    render "shared/quick_filters"
  end

  private

  def filter_option_params
    params.require(:filter_option).permit(:name, :module_class, :module_name, :filters)
  end

  def filter_option
    @filter_option ||= current_user.filter_options.find(params[:id])
  end

  def redirection_url
    public_send("#{@filter_option.module_name}_path") + "?#{@filter_option.filter_string}"
  end
end
