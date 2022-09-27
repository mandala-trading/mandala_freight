# frozen_string_literal: true

module QuickSearchable
  module Buyer
    extend ActiveSupport::Concern

    included do
      scope :quick_search, lambda { |query|
                             joins(:country).where(
                               "buyers.name RLIKE :query OR buyers.short_name RLIKE :query
                               OR buyers.street_address RLIKE :query OR buyers.city RLIKE :query
                               OR buyers.state RLIKE :query OR buyers.zip_code RLIKE :query
                               OR countries.name RLIKE :query OR countries.short_name RLIKE :query", query:
                             )
                           }
    end
  end
end
