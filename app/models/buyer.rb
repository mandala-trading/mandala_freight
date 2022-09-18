# frozen_string_literal: true

class Buyer < ApplicationRecord
  include UserTrackable
  include Archivable
  include Discardable

  RISK_PROFILES_LIST = %w[no_risk high_risk medium_risk low_risk].freeze

  INDEX_COLUMNS = {
    name: { label: "Name", sortable: true, mandatory: true },
    short_name: { label: "Short Name", sortable: true, mandatory: false },
    street_address: { label: "Street Address", sortable: true, mandatory: false },
    city: { label: "City", sortable: true, mandatory: false },
    state: { label: "State", sortable: true, mandatory: false },
    country: { label: "Country", sortable: true, mandatory: false },
    zip_code: { label: "Zip Code", sortable: true, mandatory: false },
    risk_profile: { label: "Risk Profile", sortable: true, mandatory: false },
    status: { label: "Status", sortable: true, mandatory: false }
  }.freeze

  enum risk_profile: RISK_PROFILES_LIST.to_h { |item| [item, item] }

  strip_attributes only: %i[
    name short_name city state zip_code risk_profile remarks
  ], collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true
  belongs_to :country

  delegate :name, to: :country, prefix: true

  validates :name, presence: true, length: { maximum: 250 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :short_name, presence: true, length: { maximum: 50 },
                         uniqueness: { case_sensitive: false, scope: :account_id }
  validates :street_address, :city, :state, presence: true, length: { maximum: 250 }
  validates :zip_code, presence: true, length: { maximum: 50 }
  validates :risk_profile, presence: true, inclusion: { in: RISK_PROFILES_LIST }

  scope :order_by_name, -> { order(:name) }

  def display_status
    discarded? ? I18n.t("status.deleted") : archived_status
  end
end
