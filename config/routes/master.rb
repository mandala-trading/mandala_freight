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

    concern :quick_filterable do
      get :quick_filters, on: :collection
    end

    concern :destroyable do
      get :destroyable, on: :member
    end

    resources :countries,         concerns: %i[exportable importable filterable quick_filterable destroyable]
    resources :currencies,        concerns: %i[exportable importable filterable quick_filterable destroyable]
    resources :ports,             concerns: %i[exportable importable filterable quick_filterable destroyable]
    resources :buyers,            concerns: %i[exportable importable filterable quick_filterable destroyable]
    resources :container_details, concerns: %i[exportable importable filterable quick_filterable destroyable]
    resources :shipping_lines,    concerns: %i[exportable importable filterable quick_filterable destroyable]
    resources :freight_items,     concerns: %i[exportable importable filterable quick_filterable destroyable]
    resources :units,             concerns: %i[exportable importable filterable quick_filterable destroyable]
    resources :payment_types,     concerns: %i[exportable importable filterable quick_filterable destroyable]
    resources :charge_types,      concerns: %i[exportable importable filterable quick_filterable destroyable]
  end
end
