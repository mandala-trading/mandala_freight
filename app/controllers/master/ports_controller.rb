# frozen_string_literal: true

module Master
  class PortsController < Master::HomeController
    def index
      @search = current_account.ports.ransack(params[:q])
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
        redirect_to index_path, flash: { success: t("flash_messages.created", name: resource_name) }
      else
        render :new
      end
    end

    def edit
      port
    end

    def update
      if port.update(port_params)
        redirect_to index_path, flash: { success: t("flash_messages.updated", name: resource_name) }
      else
        render :edit
      end
    end

    private

    def port_params
      params.require(:port).permit(:name, :city, :country_id, :loading_port, :discharge_port, :transhipment_port,
                                   :delivery_port, :archived)
    end

    def port
      @port ||= current_account.ports.find(params[:id])
    end

    def page_constant
      { module_name: "master_ports", module_class: "Port" }
    end

    def included_resources
      [:country]
    end

    def resource_name
      "Port"
    end

    def resources_name
      "Ports"
    end
  end
end
