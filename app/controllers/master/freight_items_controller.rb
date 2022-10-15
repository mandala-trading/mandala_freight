# frozen_string_literal: true

module Master
  class FreightItemsController < Master::HomeController
    def index
      @search = current_account.freight_items.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @freight_items = pagy(@search.result, items: page_setting.page_items)
    end

    def show
      freight_item
    end

    def new
      @freight_item = current_account.freight_items.new
    end

    def create
      @freight_item = current_account.freight_items.new(freight_item_params)

      if @freight_item.save
        redirect_to index, flash: { success: t("flash_messages.created", name: resource_name) }
      else
        render :new
      end
    end

    def edit
      freight_item
    end

    def update
      if freight_item.update(freight_item_params)
        redirect_to index, flash: { success: t("flash_messages.updated", name: resource_name) }
      else
        render :edit
      end
    end

    private

    def freight_item_params
      params.require(:freight_item).permit(:name, :archived)
    end

    def freight_item
      @freight_item ||= current_account.freight_items.find(params[:id])
    end

    def page_constant
      { module_name: "master_freight_items", module_class: "FreightItem" }
    end

    def resource_name
      "Freight item"
    end

    def resources_name
      "Freight items"
    end
  end
end
