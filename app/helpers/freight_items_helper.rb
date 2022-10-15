# frozen_string_literal: true

module FreightItemsHelper
  def freight_item_filter_list
    current_account.freight_items.order_by_name.pluck(:name, :id)
  end

  def freight_items_table_defination(key, resource)
    case key
    when :name
      details_link_using_modal(controller_name, resource, resource.name)
    when :archived
      resource.archived.display
    end
  end
end
