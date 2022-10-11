# frozen_string_literal: true

module Master
  class FreightItemsController < Master::HomeController
    before_action { active_sidebar_sub_item_option("freight_items") }
    before_action { breadcrumbs.add "Freight Items", master_freight_items_path, title: "Freight Items List" }

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
        redirect_to master_freight_items_path, flash: { success: t("flash_messages.created", name: "Freight item") }
      else
        render :new
      end
    end

    def edit
      freight_item
    end

    def update
      if freight_item.update(freight_item_params)
        redirect_to master_freight_items_path, flash: { success: t("flash_messages.updated", name: "Freight item") }
      else
        render :edit
      end
    end

    def destroy
      if freight_item.trashed
        redirect_to master_freight_items_path, flash: { success: t("flash_messages.deleted", name: "Freight item") }
      else
        redirect_to master_freight_items_path,
                    flash: { danger: t("flash_messages.already_deleted", name: "Freight item") }
      end
    end

    def archive
      if freight_item.archive
        redirect_to master_freight_items_path, flash: { success: t("flash_messages.archived", name: "Freight item") }
      else
        redirect_to master_freight_items_path,
                    flash: { danger: t("flash_messages.already_archived", name: "Freight item") }
      end
    end

    def unarchive
      if freight_item.unarchive
        redirect_to master_freight_items_path, flash: { success: t("flash_messages.unarchived", name: "Freight item") }
      else
        redirect_to master_freight_items_path,
                    flash: { danger: t("flash_messages.already_unarchived", name: "Freight item") }
      end
    end

    def restore
      if freight_item.restore
        redirect_to master_freight_items_path, flash: { success: t("flash_messages.restored", name: "Freight item") }
      else
        redirect_to master_freight_items_path,
                    flash: { danger: t("flash_messages.already_restored", name: "Freight item") }
      end
    end

    def export
      @search = current_account.freight_items.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @freight_items = @search.result

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] =
            "attachment; filename=freight_items_#{I18n.l(Time.current, format: :filename)}.xlsx"
        end
      end
    end

    def import
      Importers::FreightItemsImportService.call(params[:file], current_user)
      redirect_to master_freight_items_path, flash: { success: t("flash_messages.imported", name: "Freight items") }
    end

    private

    def freight_item_params
      params.require(:freight_item).permit(:name)
    end

    def freight_item
      @freight_item ||= current_account.freight_items.find(params[:id])
    end

    def page_constant
      { module_name: "master_freight_items", module_class: "FreightItem" }
    end
  end
end
