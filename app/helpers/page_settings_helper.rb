# frozen_string_literal: true

module PageSettingsHelper
  def all_index_columns
    @page_setting.index_columns
  end

  def enabled_grid_option_keys
    @page_setting.enabled_index_column_keys
  end

  def generate_table_header(key)
    if all_index_columns[key][:sortable]
      content_tag("th", sort_link(@search, key, all_index_columns[key][:label]), scope: "col")
    else
      content_tag("th", all_index_columns[key][:label], scope: "col")
    end
  end
end
