# frozen_string_literal: true

module Master
  class CurrenciesController < Master::HomeController
    before_action { active_sidebar_sub_item_option("currencies") }
    before_action { breadcrumbs.add "Currencies", master_currencies_path, title: "Currencies List" }

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
        redirect_to master_currencies_path, flash: { success: t("flash_messages.created", name: "Currency") }
      else
        render :new
      end
    end

    def edit
      currency
    end

    def update
      if currency.update(currency_params)
        redirect_to master_currencies_path, flash: { success: t("flash_messages.updated", name: "Currency") }
      else
        render :edit
      end
    end

    def destroy
      if currency.trashed
        redirect_to master_currencies_path, flash: { success: t("flash_messages.deleted", name: "Currency") }
      else
        redirect_to master_currencies_path, flash: { danger: t("flash_messages.already_deleted", name: "Currency") }
      end
    end

    def archive
      if currency.archive
        redirect_to master_currencies_path, flash: { success: t("flash_messages.archived", name: "Currency") }
      else
        redirect_to master_currencies_path, flash: { danger: t("flash_messages.already_archived", name: "Currency") }
      end
    end

    def unarchive
      if currency.unarchive
        redirect_to master_currencies_path, flash: { success: t("flash_messages.unarchived", name: "Currency") }
      else
        redirect_to master_currencies_path, flash: { danger: t("flash_messages.already_unarchived", name: "Currency") }
      end
    end

    def restore
      if currency.restore
        redirect_to master_currencies_path, flash: { success: t("flash_messages.restored", name: "Currency") }
      else
        redirect_to master_currencies_path, flash: { danger: t("flash_messages.already_restored", name: "Currency") }
      end
    end

    def export
      @search = current_account.currencies.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @currencies = @search.result

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] =
            "attachment; filename=currencies_#{I18n.l(Time.current, format: :filename)}.xlsx"
        end
      end
    end

    def import
      Importers::CurrenciesImportService.call(params[:file], current_user)
      redirect_to master_currencies_path, flash: { success: t("flash_messages.imported", name: "Currencies") }
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
  end
end
