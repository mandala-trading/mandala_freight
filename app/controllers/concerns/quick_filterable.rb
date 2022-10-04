# frozen_string_literal: true

module QuickFilterable
  extend ActiveSupport::Concern

  def quick_filters
    @filter_options = current_user.current_user.find_filter_options(page_constant)
    render "shared/quick_filters"
  end
end
