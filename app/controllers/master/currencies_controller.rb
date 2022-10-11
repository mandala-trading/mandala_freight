# frozen_string_literal: true

module Master
  class CurrenciesController < Master::HomeController
    def index
      @search = current_account.currencies.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @currencies = pagy(@search.result, items: page_setting.page_items)
    end

    def show
      currency
    end

    def new
      @currency = current_account.currencies.new
    end

    def create
      @currency = current_account.currencies.new(currency_params)

      if @currency.save
        redirect_to index_path, flash: { success: t("flash_messages.created", name: resource_name) }
      else
        render :new
      end
    end

    def edit
      currency
    end

    def update
      if currency.update(currency_params)
        redirect_to index_path, flash: { success: t("flash_messages.updated", name: resource_name) }
      else
        render :edit
      end
    end

    private

    def currency_params
      params.require(:currency).permit(:name, :code, :symbol)
    end

    def currency
      @currency ||= current_account.currencies.find(params[:id])
    end

    def page_constant
      { module_name: "master_currencies", module_class: "Currency" }
    end

    def resource_name
      "Currency"
    end

    def resources_name
      "Currencies"
    end
  end
end
