# frozen_string_literal: true

module Importers
  class FreightItemImportService < Importers::ImportService
    protected

    def initialize_resource(data)
      @current_account.freight_items.new(name: data[:name])
    end

    def error_csv_header
      ["Name", "Error Message"]
    end
  end
end
