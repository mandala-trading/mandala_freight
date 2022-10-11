# frozen_string_literal: true

module DestroyAction
  extend ActiveSupport::Concern

  def destroy
    if record.trashed
      redirect_to index_path, flash: { success: t("flash_messages.deleted", name: resource_name) }
    else
      redirect_to index_path, flash: { danger: t("flash_messages.already_deleted", name: resource_name) }
    end
  end

  private

  def record
    current_account.public_send(controller_name).find(params[:id])
  end
end
