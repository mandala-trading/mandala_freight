# frozen_string_literal: true

module Master
  class BuyersController < Master::HomeController
    def index
      @search = current_account.buyers.ransack(params[:q])
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
        redirect_to index_path, flash: { success: t("flash_messages.created", name: resource_name) }
      else
        render :new
      end
    end

    def edit
      buyer
    end

    def update
      if buyer.update(buyer_params)
        redirect_to index_path, flash: { success: t("flash_messages.updated", name: resource_name) }
      else
        render :edit
      end
    end

    private

    def buyer_params
      params.require(:buyer).permit(:name, :short_name, :street_address, :city, :state, :zip_code, :risk_profile,
                                    :remarks, :country_id)
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

    def resource_name
      "Buyer"
    end

    def resources_name
      "Buyers"
    end
  end
end
