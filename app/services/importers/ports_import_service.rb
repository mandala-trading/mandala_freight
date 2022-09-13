# frozen_string_literal: true

module Importers
  class PortsImportService < Importers::ImportService
    protected

    def initialize_resource(data)
      @current_account.ports.new(
        name: data[:name],
        city: data[:city],
        country_id: find_country(data[:country])&.id,
        loading_port: sanitize_flag(data[:loading_port]),
        transhipment_port: sanitize_flag(data[:transhipment_port]),
        discharge_port: sanitize_flag(data[:discharge_port]),
        delivery_port: sanitize_flag(data[:delivery_port])
      )
    end

    def error_csv_header
      ["Name", "City", "Country", "Loading Port", "Transhipment Port", "Discharge Port", "Delivery Port",
       "Error Message"]
    end

    def resources_name
      "Ports"
    end
  end
end
