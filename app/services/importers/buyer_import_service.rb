# frozen_string_literal: true

module Importers
  class BuyerImportService < Importers::ImportService
    protected

    def initialize_resource(data)
      @current_account.buyers.new(
        name: data[:name],
        short_name: data[:short_name],
        street_address: data[:street_address],
        city: data[:city],
        state: data[:state],
        zip_code: data[:zip_code],
        risk_profile: sanitize_risk_profile(data[:risk_profile]),
        remarks: data[:remarks],
        country_id: find_country(data[:country])&.id
      )
    end

    def error_csv_header
      ["Name", "Short Name", "Street Address", "City", "State", "Country", "Zip Code", "Risk Profile", "Remarks",
       "Error Message"]
    end
  end
end
