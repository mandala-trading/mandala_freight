# frozen_string_literal: true

module QuickSearchable
  module Port
    extend ActiveSupport::Concern

    included do
      scope :quick_search, lambda { |query|
                             joins(:country).where(
                               "ports.name RLIKE :query OR ports.city RLIKE :query
                               OR countries.name RLIKE :query OR countries.short_name RLIKE :query", query:
                             )
                           }
    end
  end
end
