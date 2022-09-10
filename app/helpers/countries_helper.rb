# frozen_string_literal: true

module CountriesHelper
  def country_filter_list
    current_account.countries.order_by_name.pluck(:name, :id)
  end

  def countries_table_defination(key, resource)
    case key
    when :name
      details_link_using_modal(controller_name, resource, resource.name)
    when :short_name
      resource.short_name
    when :status
      resource.archived_status
    end
  end
end
