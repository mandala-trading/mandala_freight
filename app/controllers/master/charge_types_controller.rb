# frozen_string_literal: true

module Master
  class ChargeTypesController < Master::HomeController
    def index
      @search = current_account.charge_types.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @charge_types = pagy(@search.result, items: page_setting.page_items)
    end

    def show
      charge_type
    end

    def new
      @charge_type = current_account.charge_types.new
    end

    def create
      @charge_type = current_account.charge_types.new(charge_type_params)

      if @charge_type.save
        redirect_to index_path, flash: { success: t("flash_messages.created", name: resource_name) }
      else
        render :new
      end
    end

    def edit
      charge_type
    end

    def update
      if charge_type.update(charge_type_params)
        redirect_to index_path, flash: { success: t("flash_messages.updated", name: resource_name) }
      else
        render :edit
      end
    end

    private

    def charge_type_params
      params.require(:charge_type).permit(:name)
    end

    def charge_type
      @charge_type ||= current_account.charge_types.find(params[:id])
    end

    def page_constant
      { module_name: "master_charge_types", module_class: "ChargeType" }
    end

    def resource_name
      "Charge type"
    end

    def resources_name
      "Charge types"
    end
  end
end
