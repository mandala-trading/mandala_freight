# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :master do
    concern :exportable do
      get :export, on: :collection
    end

    concern :filterable do
      get :filter, on: :collection
    end

    concern :importable do
      post :import, on: :collection
    end

    resources :countries, concerns: %i[exportable importable filterable]
  end
end