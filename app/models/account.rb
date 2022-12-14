# frozen_string_literal: true

class Account < ApplicationRecord
  strip_attributes only: %i[name time_zone], collapse_spaces: true, replace_newlines: true

  has_many :users, dependent: :destroy
  has_many :countries, dependent: :destroy
  has_many :currencies, dependent: :destroy
  has_many :ports, dependent: :destroy
  has_many :buyers, dependent: :destroy
  has_many :shipping_lines, dependent: :destroy
  has_many :container_details, dependent: :destroy
  has_many :freight_items, dependent: :destroy
  has_many :units, dependent: :destroy
  has_many :payment_types, dependent: :destroy
  has_many :charge_types, dependent: :destroy

  validates :name, presence: true, length: { maximum: 250 }
  validates :time_zone, presence: true, length: { maximum: 50 }
end
