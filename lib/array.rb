# frozen_string_literal: true

class Array
  def display
    join(", ")
  end

  def display_dropdown
    map { |el| [el.display, el] }
  end
end
