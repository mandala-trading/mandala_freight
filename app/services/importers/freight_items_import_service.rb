# frozen_string_literal: true

module Importers
  class FreightItemsImportService < Importers::ImportService
    protected

    def initialize_resource(data)
      @current_account.freight_items.new(name: data[:name])
    end

    def error_csv_header
      ["Name", "Error Message"]
    end

    def resources_name
      "Freight items"
    end
  end
end
