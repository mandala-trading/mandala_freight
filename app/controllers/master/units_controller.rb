# frozen_string_literal: true

module Master
  class UnitsController < Master::HomeController
    before_action { active_sidebar_sub_item_option("units") }
    before_action { breadcrumbs.add "Units", master_units_path, title: "Units List" }

    def index
      @search = current_account.units.public_send(page_setting.filter).ransack(params[:q])
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
        redirect_to master_units_path, flash: { success: t("flash_messages.created", name: "Unit") }
      else
        render :new
      end
    end

    def edit
      unit
    end

    def update
      if unit.update(unit_params)
        redirect_to master_units_path, flash: { success: t("flash_messages.updated", name: "Unit") }
      else
        render :edit
      end
    end

    def destroy
      if unit.destroy
        redirect_to master_units_path, flash: { success: t("flash_messages.deleted", name: "Unit") }
      else
        redirect_to master_units_path,
                    flash: { danger: t("flash_messages.already_deleted", name: "Unit") }
      end
    end

    def restore
      if unit.restore
        redirect_to master_units_path, flash: { success: t("flash_messages.restored", name: "Unit") }
      else
        redirect_to master_units_path,
                    flash: { danger: t("flash_messages.already_restored", name: "Unit") }
      end
    end

    def filter
      @search = current_account.units.ransack(params[:q])
      render "shared/filter"
    end

    def export
      @search = current_account.units.public_send(page_setting.filter).ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @units = @search.result

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] =
            "attachment; filename=units_#{I18n.l(Time.current, format: :filename)}.xlsx"
        end
      end
    end

    def import
      Importers::UnitsImportService.call(params[:file], current_user)
      redirect_to master_units_path, flash: { success: t("flash_messages.imported", name: "Units") }
    end

    private

    def unit_params
      params.require(:unit).permit(:name, :container_type, :archived)
    end

    def unit
      @unit ||= current_account.units.find(params[:id])
    end

    def page_setting_constant
      { module_name: "master_units", module_class: "Unit" }
    end
  end
end
