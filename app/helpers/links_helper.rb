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
            class: "btn btn-danger",
            title: "Delete Confirmation"
  end

  def delete_confirm_link(controller_name, resource)
    link_to "Delete",
            url_for(controller: controller_name, action: "destroyable", id: resource.id),
            remote: true,
            class: "btn btn-danger-light btn-sm",
            title: "Delete #{controller_name.singular_display}"
  end

  def details_link(controller_name, resource, link_title)
    link_to link_title,
            url_for(controller: controller_name, action: "show", id: resource.id),
            title: "Show #{controller_name.singular_display}"
  end
end
