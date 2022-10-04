# frozen_string_literal: true

module Master
  class BuyersController < Master::HomeController
    before_action { active_sidebar_sub_item_option("buyers") }
    before_action { breadcrumbs.add "Buyers", master_buyers_path, title: "Buyers List" }

    def index
      @search = current_account.buyers.public_send(page_setting.filter).ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @buyers = pagy(@search.result.includes(included_resources), items: page_setting.page_items)
    end

    def show
      breadcrumbs.add buyer.name, master_buyer_path(buyer), title: "Buyer Details"
    end

    def new
      @buyer = current_account.buyers.new
    end

    def create
      @buyer = current_account.buyers.new(buyer_params)

      if @buyer.save
        redirect_to master_buyers_path, flash: { success: t("flash_messages.created", name: "Buyer") }
      else
        render :new
      end
    end

    def edit
      buyer
    end

    def update
      if buyer.update(buyer_params)
        redirect_to master_buyers_path, flash: { success: t("flash_messages.updated", name: "Buyer") }
      else
        render :edit
      end
    end

    def destroy
      if buyer.destroy
        redirect_to master_buyers_path, flash: { success: t("flash_messages.deleted", name: "Buyer") }
      else
        redirect_to master_buyers_path, flash: { danger: t("flash_messages.already_deleted", name: "Buyer") }
      end
    end

    def restore
      if buyer.restore
        redirect_to master_buyers_path, flash: { success: t("flash_messages.restored", name: "Buyer") }
      else
        redirect_to master_buyers_path, flash: { danger: t("flash_messages.already_restored", name: "Buyer") }
      end
    end

    def filter
      @search = current_account.buyers.ransack(params[:q])
      render "shared/filter"
    end

    def export
      @search = current_account.buyers.public_send(page_setting.filter).ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @buyers = @search.result.includes(included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] =
            "attachment; filename=buyers_#{I18n.l(Time.current, format: :filename)}.xlsx"
        end
      end
    end

    def import
      Importers::BuyersImportService.call(params[:file], current_user)
      redirect_to master_buyers_path, flash: { success: t("flash_messages.imported", name: "Buyers") }
    end

    private

    def buyer_params
      params.require(:buyer).permit(:name, :short_name, :street_address, :city, :state, :zip_code,
                                    :risk_profile, :remarks, :archived, :country_id)
    end

    def buyer
      @buyer ||= current_account.buyers.find(params[:id])
    end

    def page_constant
      { module_name: "master_buyers", module_class: "Buyer" }
    end

    def included_resources
      [:country]
    end
  end
end
