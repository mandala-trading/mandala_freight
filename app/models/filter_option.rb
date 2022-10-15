# frozen_string_literal: true

class FilterOption < ApplicationRecord
  MODULE_NAMES = %w[master_countries master_currencies master_ports master_buyers master_container_details
                    master_shipping_lines master_freight_items master_units master_payment_types
                    master_charge_types].freeze
  MODULE_CLASSES = %w[Country Currency Port Buyer ContainerDetail ShippingLine FreightItem Unit PaymentType
                      ChargeType].freeze

  belongs_to :user

  validates :module_name, presence: true, length: { maximum: 250 }, inclusion: { in: MODULE_NAMES }
  validates :module_class, presence: true, length: { maximum: 250 }, inclusion: { in: MODULE_CLASSES }
  validates :name, presence: true, length: { maximum: 250 },
                   uniqueness: { case_sensitive: false, scope: %i[module_name module_class user_id] }
  validates :filters, presence: true

  scope :search_by_page, ->(options) { where(options) }
  scope :order_by_name, -> { order(:name) }

  def filter_string
    JSON.parse(filters).map { |k, v| "q[#{k}]=#{v}" }.join("&")
  end

  def filter_string_with_id
    "#{filter_string}&filter_option=#{id}"
  end

  def page_constant
    { module_name:, module_class: }
  end
end
