# frozen_string_literal: true

module ModalLinksHelper
  def new_link_using_modal(controller_name)
    link_to "Add New",
            url_for(controller: controller_name, action: "new"),
            remote: true,
            class: "btn btn-primary my-0",
            title: "Add #{controller_name.singular_display}"
  end

  def filter_link_using_modal(controller_name)
    link_to "Filter",
            url_for(controller: controller_name, action: "filter",
                    params: { q: params[:q]&.to_unsafe_h.to_h }),
            remote: true,
            title: "Filter #{controller_name.display}",
            class: "btn btn-light my-0"
  end

  def edit_link_using_modal(controller_name, resource)
    link_to "Edit",
            url_for(controller: controller_name, action: "edit", id: resource.id),
            remote: true,
            class: "btn btn-light btn-sm",
            title: "Edit #{controller_name.singular_display}"
  end

  def show_link_using_modal(controller_name, resource)
    link_to "Show",
            url_for(controller: controller_name, action: "show", id: resource.id),
            remote: true,
            class: "btn btn-light btn-sm",
            title: "Show #{controller_name.singular_display}"
  end

  def details_link_using_modal(controller_name, resource, link_title)
    link_to link_title,
            url_for(controller: controller_name, action: "show", id: resource.id),
            remote: true,
            title: "Show #{controller_name.singular_display}"
  end

  def change_logs_link_using_modal(controller_name, resource)
    link_to "Logs",
            url_for(controller: controller_name, action: "change_logs", id: resource.id),
            remote: true,
            title: "Show Change Logs",
            class: "btn btn-light btn-sm"
  end

  def export_link(controller_name)
    link_to "Export",
            url_for(controller: controller_name, action: "export", format: "xlsx",
                    params: { q: params[:q]&.to_unsafe_h.to_h }),
            title: "Export #{controller_name.display}",
            class: "dropdown-item"
  end

  def import_link_using_modal(controller_name)
    link_to "Import",
            "#",
            data: { "bs-toggle": "modal", "bs-target": "#import_modal" },
            title: "Import #{controller_name.display}",
            class: "dropdown-item"
  end
end
