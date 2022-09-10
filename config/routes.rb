# frozen_string_literal: true

Rails.application.routes.draw do
  # Load all route files
  Dir[Rails.root.join("config/routes/**/*.rb")].each { |r| load(r) }

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users

  resources :page_settings, only: %i[edit update]

  root "home#index"
  get  "/dashboard", to: "home#dashboard"
end
