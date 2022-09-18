# frozen_string_literal: true

module FiltersHelper
  def status_filter_list
    [["Active", false], ["Archived", true]]
  end

  def port_flag_filter_list
    [["Yes", true], ["No", false]]
  end

  def container_type_flag_filter_list
    [["Yes", true], ["No", false]]
  end
end
