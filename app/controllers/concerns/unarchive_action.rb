# frozen_string_literal: true

module UnarchiveAction
  extend ActiveSupport::Concern

  def unarchive
    if record.unarchive
      redirect_to index_path, flash: { success: t("flash_messages.unarchived", name: resource_name) }
    else
      redirect_to index_path, flash: { danger: t("flash_messages.already_unarchived", name: resource_name) }
    end
  end

  private

  def record
    current_account.public_send(controller_name).find(params[:id])
  end
end
