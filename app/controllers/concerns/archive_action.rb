# frozen_string_literal: true

module ArchiveAction
  extend ActiveSupport::Concern

  def archive
    if record.archive
      redirect_to index_path, flash: { success: t("flash_messages.archived", name: resource_name) }
    else
      redirect_to index_path, flash: { danger: t("flash_messages.already_archived", name: resource_name) }
    end
  end

  private

  def record
    current_account.public_send(controller_name).find(params[:id])
  end
end
