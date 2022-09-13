# frozen_string_literal: true

module Importers
  class CurrenciesImportService < Importers::ImportService
    protected

    def initialize_resource(data)
      @current_account.currencies.new(name: data[:name], code: data[:code], symbol: data[:symbol])
    end

    def error_csv_header
      ["Name", "Code", "Symbol", "Error Message"]
    end

    def resources_name
      "currencies"
    end
  end
end
