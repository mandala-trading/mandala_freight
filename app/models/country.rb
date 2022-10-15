# frozen_string_literal: true

class Country < ApplicationRecord
  include QuickSearchable::Country
  include UserTrackable
  include Archivable

  INDEX_COLUMNS = {
    name: { label: "Name", sortable: true, sort_key: :name, mandatory: true },
    short_name: { label: "Short Name", sortable: true, sort_key: :short_name, mandatory: false },
    archived: { label: "Archived", sortable: true, sort_key: :archived, mandatory: false }
  }.freeze

  strip_attributes only: %i[name short_name], collapse_spaces: true, replace_newlines: true

  has_many :buyers, dependent: :destroy
  has_many :shipping_lines, dependent: :destroy
  has_many :ports, dependent: :destroy

  belongs_to :account, counter_cache: true

  validates :name, presence: true, length: { maximum: 250 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :short_name, presence: true, length: { maximum: 20 },
                         uniqueness: { case_sensitive: false, scope: :account_id }

  scope :order_by_name, -> { order(:name) }

  def self.ransackable_scopes(_auth_object = nil)
    %i[quick_search]
  end

  def destroyable?
    buyers.blank? && shipping_lines.blank? && ports.blank?
  end
end
