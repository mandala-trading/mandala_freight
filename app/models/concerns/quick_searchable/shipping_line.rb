# frozen_string_literal: true

module QuickSearchable
  module ShippingLine
    extend ActiveSupport::Concern

    included do
      scope :quick_search, lambda { |query|
                             joins(:country).where(
                               "shipping_lines.name RLIKE :query OR shipping_lines.short_name RLIKE :query
                               OR shipping_lines.street_address RLIKE :query OR shipping_lines.city RLIKE :query
                               OR shipping_lines.state RLIKE :query OR shipping_lines.zip_code RLIKE :query
                               OR countries.name RLIKE :query OR countries.short_name RLIKE :query", query:
                             )
                           }
    end
  end
end
