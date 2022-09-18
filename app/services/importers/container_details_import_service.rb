# frozen_string_literal: true

module Importers
  class ContainerDetailsImportService < Importers::ImportService
    protected

    def initialize_resource(data)
      @current_account.container_details.new(name: data[:name], description: data[:description])
    end

    def error_csv_header
      ["Name", "Description", "Error Message"]
    end

    def resources_name
      "Container details"
    end
  end
end
