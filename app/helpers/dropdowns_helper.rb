# frozen_string_literal: true

module DropdownsHelper
  def country_list(country_id)
    dropdown_list = current_account.countries.kept.non_archived.order_by_name.pluck(:name, :id)
    country_ids = dropdown_list.map { |e| e[1] }

    if country_id && !country_ids.include?(country_id)
      country = current_account.categories.find(country_id)
      dropdown_list.prepend([country.name, country.id])
    end

    dropdown_list
  end

  def risk_profile_list
    Buyer::RISK_PROFILES_LIST.map { |risk_profile| [risk_profile.display, risk_profile] }
  end
end
