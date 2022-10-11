# frozen_string_literal: true

module Master
  class ShippingLinesController < Master::HomeController
    def index
      @search = current_account.shipping_lines.ransack(params[:q])
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
        redirect_to index_path, flash: { success: t("flash_messages.created", name: resource_name) }
      else
        render :new
      end
    end

    def edit
      shipping_line
    end

    def update
      if shipping_line.update(shipping_line_params)
        redirect_to index_path, flash: { success: t("flash_messages.updated", name: resource_name) }
      else
        render :edit
      end
    end

    private

    def shipping_line_params
      params.require(:shipping_line).permit(:name, :short_name, :street_address, :city, :state, :zip_code,
                                            :risk_profile, :remarks, :country_id)
    end

    def shipping_line
      @shipping_line ||= current_account.shipping_lines.find(params[:id])
    end

    def page_constant
      { module_name: "master_shipping_lines", module_class: "ShippingLine" }
    end

    def included_resources
      [:country]
    end

    def resource_name
      "Shipping line"
    end

    def resources_name
      "Shipping lines"
    end
  end
end
