# frozen_string_literal: true

module BuyersHelper
  def buyer_filter_list
    current_account.buyers.order_by_name.pluck(:name, :id)
  end

  def buyers_table_defination(key, resource)
    case key
    when :name
      details_link(controller_name, resource, resource.name)
    when :short_name
      resource.short_name
    when :street_address
      resource.street_address
    when :city
      resource.city
    when :state
      resource.state
    when :zip_code
      resource.zip_code
    when :country
      details_link_using_modal("countries", resource.country, resource.country_name)
    when :risk_profile
      resource.risk_profile.display
    when :status
      resource.status.display
    end
  end
end
