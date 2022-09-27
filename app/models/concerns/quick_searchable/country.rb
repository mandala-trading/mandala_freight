# frozen_string_literal: true

module QuickSearchable
  module Country
    extend ActiveSupport::Concern

    included do
      scope :quick_search, ->(query) { where("name RLIKE :query OR short_name RLIKE :query", query:) }
    end
  end
end
