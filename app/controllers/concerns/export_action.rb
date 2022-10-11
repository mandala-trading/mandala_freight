# frozen_string_literal: true

module ExportAction
  extend ActiveSupport::Concern

  def export
    @search = current_account.public_send(controller_name).ransack(params[:q])
    @search.sorts = "id desc" if @search.sorts.empty?
    @resources = @search.result.includes(included_resources)

    respond_to do |format|
      format.xlsx do
        response.headers["Content-Disposition"] = "attachment; filename=#{filename}.xlsx"
      end
    end
  end

  private

  def filename
    "#{controller_name}_#{I18n.l(Time.current, format: :filename)}"
  end
end
