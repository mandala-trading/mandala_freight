# frozen_string_literal: true

module FiltersHelper
  def status_filter_list
    [["Active", false], ["Archived", true]]
  end
end
