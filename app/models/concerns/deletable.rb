# frozen_string_literal: true

module Deletable
  extend ActiveSupport::Concern

  included do
    scope :deleted,     -> { where(status: "deleted") }
    scope :non_deleted, -> { where.not(status: "deleted") }
  end

  def deleted?
    status == "deleted"
  end

  def non_deleted?
    status != "deleted"
  end

  def trashed
    update(status: "deleted") if non_deleted?
  end

  def restore
    update(status: "active") if deleted?
  end
end
