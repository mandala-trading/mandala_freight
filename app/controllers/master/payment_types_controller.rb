# frozen_string_literal: true

module Master
  class PaymentTypesController < Master::HomeController
    before_action { active_sidebar_sub_item_option("payment_types") }
    before_action { breadcrumbs.add "Payment Types", master_payment_types_path, title: "Payment Types List" }

    def index
      @search = current_account.payment_types.public_send(page_setting.filter).ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @payment_types = pagy(@search.result, items: page_setting.page_items)
    end

    def show
      payment_type
    end

    def new
      @payment_type = current_account.payment_types.new
    end

    def create
      @payment_type = current_account.payment_types.new(payment_type_params)

      if @payment_type.save
        redirect_to master_payment_types_path, flash: { success: t("flash_messages.created", name: "Payment type") }
      else
        render :new
      end
    end

    def edit
      payment_type
    end

    def update
      if payment_type.update(payment_type_params)
        redirect_to master_payment_types_path, flash: { success: t("flash_messages.updated", name: "Payment type") }
      else
        render :edit
      end
    end

    def destroy
      if payment_type.destroy
        redirect_to master_payment_types_path, flash: { success: t("flash_messages.deleted", name: "Payment type") }
      else
        redirect_to master_payment_types_path,
                    flash: { danger: t("flash_messages.already_deleted", name: "Payment type") }
      end
    end

    def restore
      if payment_type.restore
        redirect_to master_payment_types_path, flash: { success: t("flash_messages.restored", name: "Payment type") }
      else
        redirect_to master_payment_types_path,
                    flash: { danger: t("flash_messages.already_restored", name: "Payment type") }
      end
    end

    def filter
      @search = current_account.payment_types.ransack(params[:q])
      render "shared/filter"
    end

    def export
      @search = current_account.payment_types.public_send(page_setting.filter).ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @payment_types = @search.result

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] =
            "attachment; filename=payment_types_#{I18n.l(Time.current, format: :filename)}.xlsx"
        end
      end
    end

    def import
      Importers::PaymentTypesImportService.call(params[:file], current_user)
      redirect_to master_payment_types_path, flash: { success: t("flash_messages.imported", name: "Payment types") }
    end

    private

    def payment_type_params
      params.require(:payment_type).permit(:name, :archived)
    end

    def payment_type
      @payment_type ||= current_account.payment_types.find(params[:id])
    end

    def page_constant
      { module_name: "master_payment_types", module_class: "PaymentType" }
    end
  end
end
