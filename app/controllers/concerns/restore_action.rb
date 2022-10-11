# frozen_string_literal: true

module RestoreAction
  extend ActiveSupport::Concern

  def restore
    if record.restore
      redirect_to index_path, flash: { success: t("flash_messages.restored", name: resource_name) }
    else
      redirect_to index_path, flash: { danger: t("flash_messages.already_restored", name: resource_name) }
    end
  end

  private

  def record
    current_account.public_send(controller_name).find(params[:id])
  end
end
