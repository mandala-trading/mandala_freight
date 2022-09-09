# frozen_string_literal: true

module FiltersHelper
  def status_filter_list
    [["Active", false], ["Archived", true]]
  end

  def country_filter_list
    current_account.countries.order_by_name.pluck(:name, :id)
  end
end
