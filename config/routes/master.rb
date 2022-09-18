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

    concern :restorable do
      put :restore, on: :member
    end

    resources :countries,         concerns: %i[exportable importable filterable restorable]
    resources :currencies,        concerns: %i[exportable importable filterable restorable]
    resources :ports,             concerns: %i[exportable importable filterable restorable]
    resources :buyers,            concerns: %i[exportable importable filterable restorable]
    resources :container_details, concerns: %i[exportable importable filterable restorable]
  end
end
