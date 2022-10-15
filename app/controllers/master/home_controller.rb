# frozen_string_literal: true

module Master
  class HomeController < ApplicationController
    include FilterAction
    include QuickFilterAction
    include DestroyAction
    include ExportAction
    include ImportAction

    before_action :authenticate_user!
    before_action { page_settings_enabled_option(true) }
    before_action { filter_settings_enabled_option(true) }
    before_action { active_sidebar_item_option("master") }
    before_action { active_sidebar_sub_item_option(controller_name) }
    before_action { breadcrumbs.add "Master", nil }
    before_action { breadcrumbs.add resources_name, index_path, title: "#{resources_name} List" }

    protected

    def included_resources
      []
    end
  end
end
