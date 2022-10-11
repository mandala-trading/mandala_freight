# frozen_string_literal: true

module LinksHelper
  def export_link(controller_name)
    link_to "Export",
            url_for(controller: controller_name, action: "export", format: "xlsx",
                    params: { q: params[:q]&.to_unsafe_h.to_h }),
            title: "Export #{controller_name.display}",
            class: "dropdown-item"
  end

  def archive_link(controller_name, resource)
    link_to "Archive",
            url_for(controller: controller_name, action: "archive", id: resource.id),
            method: :put,
            data: { confirm: "Are you sure you want to archive the #{controller_name.singular_downcase_display}?" },
            class: "btn btn-light btn-sm",
            title: "Archive #{controller_name.singular_display}"
  end

  def unarchive_link(controller_name, resource)
    link_to "Unarchive",
            url_for(controller: controller_name, action: "unarchive", id: resource.id),
            method: :put,
            data: { confirm: "Are you sure you want to unarchive the #{controller_name.singular_downcase_display}?" },
            class: "btn btn-light btn-sm",
            title: "Unarchive #{controller_name.singular_display}"
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

  def details_link(controller_name, resource, link_title)
    link_to link_title,
            url_for(controller: controller_name, action: "show", id: resource.id),
            title: "Show #{controller_name.singular_display}"
  end
end
