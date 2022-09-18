# frozen_string_literal: true

module Importers
  class PaymentTypesImportService < Importers::ImportService
    protected

    def initialize_resource(data)
      @current_account.payment_types.new(name: data[:name])
    end

    def error_csv_header
      ["Name", "Error Message"]
    end

    def resources_name
      "Payment Types"
    end
  end
end
