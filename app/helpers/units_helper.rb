# frozen_string_literal: true

module UnitsHelper
  def units_filter_list
    current_account.units.order_by_name.pluck(:name, :id)
  end

  def units_table_defination(key, resource)
    case key
    when :name
      details_link_using_modal(controller_name, resource, resource.name)
    when :container_type
      resource.container_type.display
    when :archived
      resource.archived.display
    end
  end
end
