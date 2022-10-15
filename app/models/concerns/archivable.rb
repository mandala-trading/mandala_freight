# frozen_string_literal: true

module Archivable
  extend ActiveSupport::Concern

  included do
    validates :archived, inclusion: { in: [true, false] }

    scope :archived,     -> { where(archived: true) }
    scope :non_archived, -> { where(archived: false) }
  end

  def archived?
    archived?
  end

  def non_archived?
    !archived?
  end
end
