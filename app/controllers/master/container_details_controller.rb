# frozen_string_literal: true

module Master
  class ContainerDetailsController < Master::HomeController
    def index
      @search = current_account.container_details.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @container_details = pagy(@search.result, items: page_setting.page_items)
    end

    def show
      container_detail
    end

    def new
      @container_detail = current_account.container_details.new
    end

    def create
      @container_detail = current_account.container_details.new(container_detail_params)

      if @container_detail.save
        redirect_to index_path, flash: { success: t("flash_messages.created", name: resource_name) }
      else
        render :new
      end
    end

    def edit
      container_detail
    end

    def update
      if container_detail.update(container_detail_params)
        redirect_to index_path, flash: { success: t("flash_messages.updated", name: resource_name) }
      else
        render :edit
      end
    end

    private

    def container_detail_params
      params.require(:container_detail).permit(:name, :description)
    end

    def container_detail
      @container_detail ||= current_account.container_details.find(params[:id])
    end

    def page_constant
      { module_name: "master_container_details", module_class: "ContainerDetail" }
    end

    def resource_name
      "Container detail"
    end

    def resources_name
      "Container details"
    end
  end
end
