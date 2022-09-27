# frozen_string_literal: true

module QuickSearchable
  module ChargeType
    extend ActiveSupport::Concern

    included do
      scope :quick_search, ->(query) { where("name RLIKE :query", query:) }
    end
  end
end
