# frozen_string_literal: true

module Discardable
  extend ActiveSupport::Concern
  include Discard::Model

  def destroy
    discard
  end

  def restore
    undiscard
  end
end
