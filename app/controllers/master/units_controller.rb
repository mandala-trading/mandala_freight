# frozen_string_literal: true

module Master
  class UnitsController < Master::HomeController
    def index
      @search = current_account.units.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @units = pagy(@search.result, items: page_setting.page_items)
    end

    def show
      unit
    end

    def new
      @unit = current_account.units.new
    end

    def create
      @unit = current_account.units.new(unit_params)

      if @unit.save
        redirect_to index_path, flash: { success: t("flash_messages.created", name: resource_name) }
      else
        render :new
      end
    end

    def edit
      unit
    end

    def update
      if unit.update(unit_params)
        redirect_to index_path, flash: { success: t("flash_messages.updated", name: resource_name) }
      else
        render :edit
      end
    end

    private

    def unit_params
      params.require(:unit).permit(:name, :container_type)
    end

    def unit
      @unit ||= current_account.units.find(params[:id])
    end

    def page_constant
      { module_name: "master_units", module_class: "Unit" }
    end

    def resource_name
      "Unit"
    end

    def resources_name
      "Units"
    end
  end
end
