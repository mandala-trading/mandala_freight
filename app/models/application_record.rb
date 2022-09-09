# frozen_string_literal: true

require "string"

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  VALID_DECIMAL_REGEX = /\A\d+(?:\.\d{0,2})?\z/

  def class_title
    self.class.name.underscore.display
  end

  def button_name
    new_record? ? "Create" : "Update"
  end

  def form_modal_header
    new_record? ? "New #{class_title}" : "Edit #{class_title}"
  end

  def details_modal_header
    "#{class_title} Details"
  end

  def full_message_errors
    errors.full_messages.join(", ")
  end
end
