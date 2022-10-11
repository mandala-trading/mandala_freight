# frozen_string_literal: true

module Archivable
  extend ActiveSupport::Concern

  included do
    scope :active,       -> { where(status: "active") }
    scope :archived,     -> { where(status: "archived") }
    scope :non_archived, -> { where.not(status: "archived") }
  end

  def active?
    status == "active"
  end

  def non_active?
    status != "active"
  end

  def archived?
    status == "archived"
  end

  def non_archived?
    status != "archived"
  end

  def archive
    update(status: "archived") if active?
  end

  def unarchive
    update(status: "active") if archived?
  end
end
