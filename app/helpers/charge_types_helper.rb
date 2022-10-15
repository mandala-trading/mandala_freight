# frozen_string_literal: true

module ChargeTypesHelper
  def charge_types_filter_list
    current_account.charge_types.order_by_name.pluck(:name, :id)
  end

  def charge_types_table_defination(key, resource)
    case key
    when :name
      details_link_using_modal(controller_name, resource, resource.name)
    when :archived
      resource.archived.display
    end
  end
end
