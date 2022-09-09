# frozen_string_literal: true

module Master
  class CountriesController < Master::HomeController
    before_action { active_sidebar_sub_item_option("countries") }
    before_action { breadcrumbs.add "Countries", master_countries_path, title: "Countries List" }

    def index
      @search = current_account.countries.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @countries = pagy(@search.result)
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
        redirect_to master_countries_path, flash: { success: t("flash_messages.created", name: "Country") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      country
    end

    def update
      if country.update(country_params)
        redirect_to master_countries_path, flash: { success: t("flash_messages.updated", name: "Country") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      if country.destroy
        redirect_to master_countries_path, status: :see_other,
                                           flash: { success: t("flash_messages.deleted", name: "Country") }
      else
        redirect_to master_countries_path, status: :unprocessable_entity, flash: { danger: "Unable to delete" }
      end
    end

    def change_logs
      @versions = country.versions.includes(:item).reverse
      render "shared/change_logs"
    end

    def filter
      @search = current_account.countries.ransack(params[:q])
      render "shared/filter"
    end

    def export
      @search = current_account.countries.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @countries = @search.result

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] =
            "attachment; filename=countries_#{I18n.l(Time.current, format: :filename)}.xlsx"
        end
      end
    end

    def import
      Importers::CountryImportService.call(params[:file], current_user)
      redirect_to master_countries_path, flash: { success: t("flash_messages.imported", name: "Countries") }
    end

    private

    def country_params
      params.require(:country).permit(:name, :short_name, :archived)
    end

    def country
      @country ||= current_account.countries.find(params[:id])
    end
  end
end
