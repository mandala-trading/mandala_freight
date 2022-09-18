# frozen_string_literal: true

module PaymentTypesHelper
  def payment_types_filter_list
    current_account.payment_types.order_by_name.pluck(:name, :id)
  end

  def payment_types_table_defination(key, resource)
    case key
    when :name
      details_link_using_modal(controller_name, resource, resource.name)
    when :status
      resource.display_status
    end
  end
end
