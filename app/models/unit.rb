# frozen_string_literal: true

class Unit < ApplicationRecord
  include QuickSearchable::Unit
  include UserTrackable
  include Archivable
  include Deletable

  STATUS_LIST = %w[active archived deleted].freeze
  INDEX_COLUMNS = {
    name: { label: "Name", sortable: true, sort_key: :name, mandatory: true },
    container_type: { label: "Container Type", sortable: true, sort_key: :container_type, mandatory: false },
    status: { label: "Status", sortable: true, sort_key: :status, mandatory: false }
  }.freeze

  strip_attributes only: :name, collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true

  validates :name, presence: true, length: { maximum: 250 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :container_type, inclusion: { in: [true, false] }

  scope :order_by_name, -> { order(:name) }

  def self.ransackable_scopes(_auth_object = nil)
    %i[quick_search]
  end
end
