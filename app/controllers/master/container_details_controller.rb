# frozen_string_literal: true

module Master
  class ContainerDetailsController < Master::HomeController
    before_action { active_sidebar_sub_item_option("container_details") }
    before_action do
      breadcrumbs.add "Container Details", master_container_details_path, title: "Container Details List"
    end

    def index
      @search = current_account.container_details.public_send(page_setting.filter).ransack(params[:q])
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
        redirect_to master_container_details_path,
                    flash: { success: t("flash_messages.created", name: "Container detail") }
      else
        render :new
      end
    end

    def edit
      container_detail
    end

    def update
      if container_detail.update(container_detail_params)
        redirect_to master_container_details_path,
                    flash: { success: t("flash_messages.updated", name: "Container detail") }
      else
        render :edit
      end
    end

    def destroy
      if container_detail.destroy
        redirect_to master_container_details_path,
                    flash: { success: t("flash_messages.deleted", name: "Container detail") }
      else
        redirect_to master_container_details_path,
                    flash: { danger: t("flash_messages.already_deleted", name: "Container detail") }
      end
    end

    def restore
      if container_detail.restore
        redirect_to master_container_details_path,
                    flash: { success: t("flash_messages.restored", name: "Container detail") }
      else
        redirect_to master_container_details_path,
                    flash: { danger: t("flash_messages.already_restored", name: "Container detail") }
      end
    end

    def filter
      @search = current_account.container_details.ransack(params[:q])
      render "shared/filter"
    end

    def export
      @search = current_account.container_details.public_send(page_setting.filter).ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @container_details = @search.result

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] =
            "attachment; filename=container_details_#{I18n.l(Time.current, format: :filename)}.xlsx"
        end
      end
    end

    def import
      Importers::ContainerDetailsImportService.call(params[:file], current_user)
      redirect_to master_container_details_path,
                  flash: { success: t("flash_messages.imported", name: "Container details") }
    end

    private

    def container_detail_params
      params.require(:container_detail).permit(:name, :description, :archived)
    end

    def container_detail
      @container_detail ||= current_account.container_details.find(params[:id])
    end

    def page_constant
      { module_name: "master_container_details", module_class: "ContainerDetail" }
    end
  end
end
