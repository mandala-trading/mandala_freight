# frozen_string_literal: true

class Currency < ApplicationRecord
  include UserTrackable
  include Archivable
  include Discardable

  INDEX_COLUMNS = {
    name: { label: "Name", sortable: true, mandatory: true },
    code: { label: "Code", sortable: true, mandatory: false },
    symbol: { label: "Symbol", sortable: true, mandatory: false },
    status: { label: "Status", sortable: true, mandatory: false }
  }.freeze

  strip_attributes only: %i[name code symbol], collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true

  validates :name, presence: true, length: { maximum: 250 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :code, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :symbol, presence: true, length: { maximum: 20 }

  def display_status
    discarded? ? I18n.t("status.deleted") : archived_status
  end
end
