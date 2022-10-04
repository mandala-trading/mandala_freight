# frozen_string_literal: true

module FilterOptionsHelper
  def applied_filters
    if params[:q].present?
      params[:q].to_unsafe_h.delete_if { |key, value| value.blank? || key == "quick_search" }
    else
      []
    end
  end

  def display_applied_filters
    applied_filters.map { |key, value| sanitize_applied_filter(key, value) }.join(" | ")
  end

  def country_filter_options(value)
    current_account.countries.where(id: value).pluck(:name)
  end

  def risk_profile_filter_options(value)
    value.display
  end

  def archived_filter_options(value)
    value.to_bool ? t("status.archived") : t("status.active")
  end

  def boolean_filter_options(value)
    value.to_bool.display
  end

  def sanitize_applied_filter(key, value)
    case key
    when "country_id_eq"
      t("applied_filters.country", names: country_filter_options(value).display)
    when "risk_profile_eq"
      t("applied_filters.risk_profile", names: risk_profile_filter_options(value))
    when "loading_port_eq"
      t("applied_filters.loading_port", names: boolean_filter_options(value))
    when "transhipment_port_eq"
      t("applied_filters.transhipment_port", names: boolean_filter_options(value))
    when "discharge_port_eq"
      t("applied_filters.discharge_port", names: boolean_filter_options(value))
    when "delivery_port_eq"
      t("applied_filters.delivery_port", names: boolean_filter_options(value))
    when "container_type_eq"
      t("applied_filters.container_type", names: boolean_filter_options(value))
    when "archived_eq"
      t("applied_filters.archived", names: archived_filter_options(value))
    when "s"
      t("applied_filters.sort_option", names: get_sort_value(value))
    end
  end

  def get_sort_value(value)
    attr, option = value.split
    "#{t("sort_attributes.#{attr}")} » #{option.capitalize}"
  end
end
