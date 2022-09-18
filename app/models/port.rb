# frozen_string_literal: true

class Port < ApplicationRecord
  include UserTrackable
  include Archivable
  include Discardable

  INDEX_COLUMNS = {
    name: { label: "Name", sortable: true, mandatory: true },
    city: { label: "City", sortable: true, mandatory: false },
    country: { label: "Country", sortable: true, mandatory: false },
    loading_port: { label: "Loading Port", sortable: true, mandatory: false },
    transhipment_port: { label: "Transhipment Port", sortable: true, mandatory: false },
    discharge_port: { label: "Discharge Port", sortable: true, mandatory: false },
    delivery_port: { label: "Delivery Port", sortable: true, mandatory: false },
    status: { label: "Status", sortable: true, mandatory: false }
  }.freeze

  strip_attributes only: %i[name city], collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true
  belongs_to :country

  delegate :name, to: :country, prefix: true

  validates :name, presence: true, length: { maximum: 250 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :city, presence: true, length: { maximum: 250 },
                   uniqueness: { case_sensitive: false, scope: %i[account_id name] }
  validates :loading_port, :transhipment_port, :discharge_port, :delivery_port, inclusion: { in: [true, false] }

  def display_status
    discarded? ? I18n.t("status.deleted") : archived_status
  end
end
