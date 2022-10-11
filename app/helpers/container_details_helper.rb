# frozen_string_literal: true

module ContainerDetailsHelper
  def container_detail_filter_list
    current_account.container_details.order_by_name.pluck(:name, :id)
  end

  def container_details_table_defination(key, resource)
    case key
    when :name
      details_link_using_modal(controller_name, resource, resource.name)
    when :description
      resource.description
    when :status
      resource.status.display
    end
  end
end
