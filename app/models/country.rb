# frozen_string_literal: true

class Country < ApplicationRecord
  include UserTrackable
  include Archivable
  include Discardable

  INDEX_COLUMNS = {
    name: { label: "Name", sortable: true, mandatory: true },
    short_name: { label: "Short Name", sortable: true, mandatory: false },
    status: { label: "Status", sortable: true, mandatory: false }
  }.freeze

  strip_attributes only: %i[name short_name], collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true

  validates :name, presence: true, length: { maximum: 250 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :short_name, presence: true, length: { maximum: 20 },
                         uniqueness: { case_sensitive: false, scope: :account_id }

  def display_status
    discarded? ? I18n.t("status.deleted") : archived_status
  end
end
