# frozen_string_literal: true

class ContainerDetail < ApplicationRecord
  include QuickSearchable::ContainerDetail
  include UserTrackable
  include Archivable
  include Discardable

  INDEX_COLUMNS = {
    name: { label: "Name", sortable: true, sort_key: :name, mandatory: true },
    description: { label: "Description", sortable: true, sort_key: :description, mandatory: false },
    status: { label: "Status", sortable: true, sort_key: :status, mandatory: false }
  }.freeze

  strip_attributes only: %i[name description], collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true

  validates :name, presence: true, length: { maximum: 250 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :description, presence: true, length: { maximum: 250 }

  scope :order_by_name, -> { order(:name) }

  def self.ransackable_scopes(_auth_object = nil)
    %i[quick_search]
  end

  def display_status
    discarded? ? I18n.t("status.deleted") : archived_status
  end
end
