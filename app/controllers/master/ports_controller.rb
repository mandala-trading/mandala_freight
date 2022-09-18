# frozen_string_literal: true

module Master
  class PortsController < Master::HomeController
    before_action { active_sidebar_sub_item_option("ports") }
    before_action { breadcrumbs.add "Ports", master_ports_path, title: "Ports List" }

    def index
      @search = current_account.ports.public_send(page_setting.filter).ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @ports = pagy(@search.result.includes(included_resources), items: page_setting.page_items)
    end

    def show
      port
    end

    def new
      @port = current_account.ports.new
    end

    def create
      @port = current_account.ports.new(port_params)

      if @port.save
        redirect_to master_ports_path, flash: { success: t("flash_messages.created", name: "Port") }
      else
        render :new
      end
    end

    def edit
      port
    end

    def update
      if port.update(port_params)
        redirect_to master_ports_path, flash: { success: t("flash_messages.updated", name: "Port") }
      else
        render :edit
      end
    end

    def destroy
      if port.destroy
        redirect_to master_ports_path, flash: { success: t("flash_messages.deleted", name: "Port") }
      else
        redirect_to master_ports_path, flash: { danger: t("flash_messages.already_deleted", name: "Port") }
      end
    end

    def restore
      if port.restore
        redirect_to master_ports_path, flash: { success: t("flash_messages.restored", name: "Port") }
      else
        redirect_to master_ports_path, flash: { danger: t("flash_messages.already_restored", name: "Port") }
      end
    end

    def filter
      @search = current_account.ports.ransack(params[:q])
      render "shared/filter"
    end

    def export
      @search = current_account.ports.public_send(page_setting.filter).ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @ports = @search.result.includes(included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] =
            "attachment; filename=ports_#{I18n.l(Time.current, format: :filename)}.xlsx"
        end
      end
    end

    def import
      Importers::PortsImportService.call(params[:file], current_user)
      redirect_to master_ports_path, flash: { success: t("flash_messages.imported", name: "Ports") }
    end

    private

    def port_params
      params.require(:port).permit(:name, :city, :country_id, :archived, :loading_port, :discharge_port,
                                   :transhipment_port, :delivery_port)
    end

    def port
      @port ||= current_account.ports.find(params[:id])
    end

    def page_setting_constant
      { module_name: "master_ports", module_class: "Port" }
    end

    def included_resources
      [:country]
    end
  end
end
