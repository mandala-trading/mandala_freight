# frozen_string_literal: true

module Master
  class HomeController < ApplicationController
    include QuickFilterable

    before_action :authenticate_user!
    before_action { breadcrumbs.add "Master", nil }
    before_action { active_sidebar_item_option("master") }
  end
end
