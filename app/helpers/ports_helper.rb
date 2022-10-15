# frozen_string_literal: true

module PortsHelper
  def port_filter_list
    current_account.ports.order_by_name.pluck(:name, :id)
  end

  def ports_table_defination(key, resource)
    case key
    when :name
      details_link_using_modal(controller_name, resource, resource.name)
    when :city
      resource.city
    when :country
      details_link_using_modal("countries", resource.country, resource.country_name)
    when :loading_port
      resource.loading_port.display
    when :transhipment_port
      resource.transhipment_port.display
    when :discharge_port
      resource.discharge_port.display
    when :delivery_port
      resource.delivery_port.display
    when :archived
      resource.archived.display
    end
  end
end
