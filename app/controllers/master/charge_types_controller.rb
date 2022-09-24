# frozen_string_literal: true

module Master
  class ChargeTypesController < Master::HomeController
    before_action { active_sidebar_sub_item_option("charge_types") }
    before_action { breadcrumbs.add "Charge Types", master_charge_types_path, title: "Charge Types List" }

    def index
      @search = current_account.charge_types.public_send(page_setting.filter).ransack(params[:q])
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
        redirect_to master_charge_types_path, flash: { success: t("flash_messages.created", name: "Charge type") }
      else
        render :new
      end
    end

    def edit
      charge_type
    end

    def update
      if charge_type.update(charge_type_params)
        redirect_to master_charge_types_path, flash: { success: t("flash_messages.updated", name: "Charge type") }
      else
        render :edit
      end
    end

    def destroy
      if charge_type.destroy
        redirect_to master_charge_types_path, flash: { success: t("flash_messages.deleted", name: "Charge type") }
      else
        redirect_to master_charge_types_path,
                    flash: { danger: t("flash_messages.already_deleted", name: "Charge type") }
      end
    end

    def restore
      if charge_type.restore
        redirect_to master_charge_types_path, flash: { success: t("flash_messages.restored", name: "Charge type") }
      else
        redirect_to master_charge_types_path,
                    flash: { danger: t("flash_messages.already_restored", name: "Charge type") }
      end
    end

    def filter
      @search = current_account.charge_types.ransack(params[:q])
      render "shared/filter"
    end

    def export
      @search = current_account.charge_types.public_send(page_setting.filter).ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @charge_types = @search.result

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] =
            "attachment; filename=charge_types_#{I18n.l(Time.current, format: :filename)}.xlsx"
        end
      end
    end

    def import
      Importers::ChargeTypesImportService.call(params[:file], current_user)
      redirect_to master_charge_types_path, flash: { success: t("flash_messages.imported", name: "Charge types") }
    end

    private

    def charge_type_params
      params.require(:charge_type).permit(:name, :archived)
    end

    def charge_type
      @charge_type ||= current_account.charge_types.find(params[:id])
    end

    def page_setting_constant
      { module_name: "master_charge_types", module_class: "ChargeType" }
    end
  end
end
