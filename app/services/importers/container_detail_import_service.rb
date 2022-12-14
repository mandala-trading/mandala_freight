# frozen_string_literal: true

module Importers
  class ContainerDetailImportService < Importers::ImportService
    protected

    def initialize_resource(data)
      @current_account.container_details.new(name: data[:name], description: data[:description])
    end

    def error_csv_header
      ["Name", "Description", "Error Message"]
    end
  end
end
