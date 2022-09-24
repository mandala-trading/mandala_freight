# frozen_string_literal: true

module Importers
  class UnitsImportService < Importers::ImportService
    protected

    def initialize_resource(data)
      @current_account.units.new(name: data[:name], container_type: sanitize_flag(data[:container_type]))
    end

    def error_csv_header
      ["Name", "Container Type", "Error Message"]
    end

    def resources_name
      "Units"
    end
  end
end
