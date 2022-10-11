# frozen_string_literal: true

module Importers
  class CountryImportService < Importers::ImportService
    protected

    def initialize_resource(data)
      @current_account.countries.new(name: data[:name], short_name: data[:short_name])
    end

    def error_csv_header
      ["Name", "Short Name", "Error Message"]
    end
  end
end
