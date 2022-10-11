# frozen_string_literal: true

module ImportAction
  extend ActiveSupport::Concern

  def import
    importer_service.new(params[:file], current_user, resources_name).call
    redirect_to index_path, flash: { success: t("flash_messages.imported", name: resources_name) }
  end

  private

  def importer_service
    "Importers::#{controller_name.classify}ImportService".constantize
  end
end
