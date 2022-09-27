# frozen_string_literal: true

module QuickSearchable
  module ContainerDetail
    extend ActiveSupport::Concern

    included do
      scope :quick_search, ->(query) { where("name RLIKE :query OR description RLIKE :query", query:) }
    end
  end
end
