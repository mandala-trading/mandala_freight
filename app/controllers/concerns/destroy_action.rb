# frozen_string_literal: true

module DestroyAction
  extend ActiveSupport::Concern

  def destroyable
    resource
    render "shared/destroyable"
  end

  def destroy
    if resource.destroyable? && resource.destroy
      redirect_to index_path, flash: { success: t("flash_messages.deleted", name: resource_name) }
    else
      redirect_to index_path, flash: { danger: t("flash_messages.undeletable", name: resource_name) }
    end
  end

  private

  def resource
    @resource ||= current_account.public_send(controller_name).find(params[:id])
  end
end
