# frozen_string_literal: true

class String
  def display
    humanize.titleize
  end

  def singular_display
    singularize.humanize.titleize
  end

  def singular_downcase_display
    singularize.humanize.downcase
  end
end
