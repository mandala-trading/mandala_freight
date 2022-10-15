# frozen_string_literal: true

module QuickFilterAction
  extend ActiveSupport::Concern

  def quick_filters
    render "shared/quick_filters"
  end
end
