# frozen_string_literal: true

module LinksHelper
  def export_link(controller_name)
    link_to "Export",
            url_for(controller: controller_name, action: "export", format: "xlsx",
                    params: { q: params[:q]&.to_unsafe_h.to_h }),
            title: "Export #{controller_name.display}",
            class: "dropdown-item"
  end

  def delete_link(controller_name, resource)
    link_to "Delete",
            url_for(controller: controller_name, action: "destroy", id: resource.id),
            method: :delete,
            data: { confirm: "Are you sure you want to delete the #{controller_name.singular_downcase_display}?" },
            class: "btn btn-danger-light btn-sm",
            title: "Delete #{controller_name.singular_display}"
  end

  def restore_link(controller_name, resource)
    link_to "Restore",
            url_for(controller: controller_name, action: "restore", id: resource.id),
            method: :put,
            data: { confirm: "Are you sure you want to restore the #{controller_name.singular_downcase_display}?" },
            class: "btn btn-light btn-sm",
            title: "Restore #{controller_name.singular_display}"
  end
end
