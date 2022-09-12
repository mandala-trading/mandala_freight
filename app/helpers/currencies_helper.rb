# frozen_string_literal: true

module CurrenciesHelper
  def currency_filter_list
    current_account.currencies.order_by_name.pluck(:name, :id)
  end

  def currencies_table_defination(key, resource)
    case key
    when :name
      details_link_using_modal(controller_name, resource, resource.name)
    when :code
      resource.code
    when :symbol
      resource.symbol
    when :status
      resource.display_status
    end
  end
end
