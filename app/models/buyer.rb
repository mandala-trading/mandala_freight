# frozen_string_literal: true

class Buyer < ApplicationRecord
  include QuickSearchable::Buyer
  include UserTrackable
  include Archivable
  include Deletable

  # Do not change the order of risk profiles
  RISK_PROFILES_LIST = %w[no_risk low_risk medium_risk high_risk].freeze
  STATUS_LIST = %w[active archived deleted].freeze
  INDEX_COLUMNS = {
    name: { label: "Name", sortable: true, sort_key: :name, mandatory: true },
    short_name: { label: "Short Name", sortable: true, sort_key: :short_name, mandatory: false },
    street_address: { label: "Street Address", sortable: true, sort_key: :street_address, mandatory: false },
    city: { label: "City", sortable: true, sort_key: :city, mandatory: false },
    state: { label: "State", sortable: true, sort_key: :state, mandatory: false },
    country: { label: "Country", sortable: true, sort_key: :country_name, mandatory: false },
    zip_code: { label: "Zip Code", sortable: true, sort_key: :zip_code, mandatory: false },
    risk_profile: { label: "Risk Profile", sortable: true, sort_key: :risk_profile, mandatory: false },
    status: { label: "Status", sortable: true, sort_key: :status, mandatory: false }
  }.freeze

  enum risk_profile: RISK_PROFILES_LIST.to_h { |item| [item, item] }

  strip_attributes only: %i[
    name short_name street_address city state zip_code remarks
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

  def self.ransackable_scopes(_auth_object = nil)
    %i[quick_search]
  end
end
