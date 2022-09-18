# frozen_string_literal: true

module PageSettingsHelper
  def all_index_columns
    @page_setting.index_columns
  end

  def enabled_grid_option_keys
    @page_setting.enabled_index_column_keys
  end

  def generate_table_header(key)
    column_def = all_index_columns[key]

    if column_def[:sortable]
      content_tag("th", sort_link(@search, column_def[:sort_key], column_def[:label]), scope: "col")
    else
      content_tag("th", column_def[:label], scope: "col")
    end
  end
end
