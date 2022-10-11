# frozen_string_literal: true

module Master
  class PaymentTypesController < Master::HomeController
    def index
      @search = current_account.payment_types.ransack(params[:q])
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
        redirect_to index_path, flash: { success: t("flash_messages.created", name: resource_name) }
      else
        render :new
      end
    end

    def edit
      payment_type
    end

    def update
      if payment_type.update(payment_type_params)
        redirect_to index_path, flash: { success: t("flash_messages.updated", name: resource_name) }
      else
        render :edit
      end
    end

    private

    def payment_type_params
      params.require(:payment_type).permit(:name)
    end

    def payment_type
      @payment_type ||= current_account.payment_types.find(params[:id])
    end

    def page_constant
      { module_name: "master_payment_types", module_class: "PaymentType" }
    end

    def resource_name
      "Payment type"
    end

    def resources_name
      "Payment types"
    end
  end
end
