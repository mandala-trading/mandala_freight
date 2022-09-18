# frozen_string_literal: true

module Importers
  class ChargeTypesImportService < Importers::ImportService
    protected

    def initialize_resource(data)
      @current_account.charge_types.new(name: data[:name])
    end

    def error_csv_header
      ["Name", "Error Message"]
    end

    def resources_name
      "Charge types"
    end
  end
end
