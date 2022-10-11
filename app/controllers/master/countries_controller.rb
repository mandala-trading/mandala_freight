# frozen_string_literal: true

module Master
  class CountriesController < Master::HomeController
    def index
      @search = current_account.countries.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @countries = pagy(@search.result, items: page_setting.page_items)
    end

    def show
      country
    end

    def new
      @country = current_account.countries.new
    end

    def create
      @country = current_account.countries.new(country_params)

      if @country.save
        redirect_to index_path, flash: { success: t("flash_messages.created", name: resource_name) }
      else
        render :new
      end
    end

    def edit
      country
    end

    def update
      if country.update(country_params)
        redirect_to index_path, flash: { success: t("flash_messages.updated", name: resource_name) }
      else
        render :edit
      end
    end

    private

    def country_params
      params.require(:country).permit(:name, :short_name)
    end

    def country
      @country ||= current_account.countries.find(params[:id])
    end

    def page_constant
      { module_name: "master_countries", module_class: resource_name }
    end

    def resource_name
      "Country"
    end

    def resources_name
      "Countries"
    end
  end
end
