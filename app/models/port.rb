# frozen_string_literal: true

class Port < ApplicationRecord
  include QuickSearchable::Port
  include UserTrackable
  include Archivable

  INDEX_COLUMNS = {
    name: { label: "Name", sortable: true, sort_key: :name, mandatory: true },
    city: { label: "City", sortable: true, sort_key: :city, mandatory: false },
    country: { label: "Country", sortable: true, sort_key: :country_name, mandatory: false },
    loading_port: { label: "Loading Port", sortable: true, sort_key: :loading_port, mandatory: false },
    transhipment_port: { label: "Transhipment Port", sortable: true, sort_key: :transhipment_port, mandatory: false },
    discharge_port: { label: "Discharge Port", sortable: true, sort_key: :discharge_port, mandatory: false },
    delivery_port: { label: "Delivery Port", sortable: true, sort_key: :delivery_port, mandatory: false },
    archived: { label: "Archived", sortable: true, sort_key: :archived, mandatory: false }
  }.freeze

  strip_attributes only: %i[name city], collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true
  belongs_to :country

  delegate :name, to: :country, prefix: true

  validates :name, presence: true, length: { maximum: 250 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :city, presence: true, length: { maximum: 250 },
                   uniqueness: { case_sensitive: false, scope: %i[account_id name] }
  validates :loading_port, :transhipment_port, :discharge_port, :delivery_port, inclusion: { in: [true, false] }

  scope :order_by_name, -> { order(:name) }

  def self.ransackable_scopes(_auth_object = nil)
    %i[quick_search]
  end

  def destroyable?
    true
  end
end
