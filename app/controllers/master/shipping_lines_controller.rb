# frozen_string_literal: true

module Master
  class ShippingLinesController < Master::HomeController
    before_action { active_sidebar_sub_item_option("shipping_lines") }
    before_action { breadcrumbs.add "Shipping Lines", master_shipping_lines_path, title: "Shipping Lines List" }

    def index
      @search = current_account.shipping_lines.public_send(page_setting.filter).ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @shipping_lines = pagy(@search.result.includes(included_resources), items: page_setting.page_items)
    end

    def show
      breadcrumbs.add shipping_line.name, master_shipping_line_path(shipping_line), title: "Shipping Line Details"
    end

    def new
      @shipping_line = current_account.shipping_lines.new
    end

    def create
      @shipping_line = current_account.shipping_lines.new(shipping_line_params)

      if @shipping_line.save
        redirect_to master_shipping_lines_path, flash: { success: t("flash_messages.created", name: "Shipping line") }
      else
        render :new
      end
    end

    def edit
      shipping_line
    end

    def update
      if shipping_line.update(shipping_line_params)
        redirect_to master_shipping_lines_path, flash: { success: t("flash_messages.updated", name: "Shipping line") }
      else
        render :edit
      end
    end

    def destroy
      if shipping_line.destroy
        redirect_to master_shipping_lines_path, flash: { success: t("flash_messages.deleted", name: "Shipping line") }
      else
        redirect_to master_shipping_lines_path,
                    flash: { danger: t("flash_messages.already_deleted", name: "Shipping line") }
      end
    end

    def restore
      if shipping_line.restore
        redirect_to master_shipping_lines_path, flash: { success: t("flash_messages.restored", name: "Shipping line") }
      else
        redirect_to master_shipping_lines_path,
                    flash: { danger: t("flash_messages.already_restored", name: "Shipping line") }
      end
    end

    def filter
      @search = current_account.shipping_lines.ransack(params[:q])
      render "shared/filter"
    end

    def export
      @search = current_account.shipping_lines.public_send(page_setting.filter).ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @shipping_lines = @search.result.includes(included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] =
            "attachment; filename=shipping_lines_#{I18n.l(Time.current, format: :filename)}.xlsx"
        end
      end
    end

    def import
      Importers::ShippingLinesImportService.call(params[:file], current_user)
      redirect_to master_shipping_lines_path, flash: { success: t("flash_messages.imported", name: "Shipping lines") }
    end

    private

    def shipping_line_params
      params.require(:shipping_line).permit(:name, :short_name, :street_address, :city, :state, :zip_code,
                                            :risk_profile, :remarks, :archived, :country_id)
    end

    def shipping_line
      @shipping_line ||= current_account.shipping_lines.find(params[:id])
    end

    def page_setting_constant
      { module_name: "master_shipping_lines", module_class: "ShippingLine" }
    end

    def included_resources
      [:country]
    end
  end
end
