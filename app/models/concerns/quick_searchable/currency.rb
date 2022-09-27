# frozen_string_literal: true

module QuickSearchable
  module Currency
    extend ActiveSupport::Concern

    included do
      scope :quick_search, lambda { |query|
                             where("name RLIKE :query OR code RLIKE :query OR symbol RLIKE :query", query:)
                           }
    end
  end
end
