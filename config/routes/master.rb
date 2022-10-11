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

    concern :archivable do
      put :archive, on: :member
      put :unarchive, on: :member
    end

    concern :quick_filterable do
      get :quick_filters, on: :collection
    end

    resources :countries,         concerns: %i[exportable importable filterable quick_filterable archivable restorable]
    resources :currencies,        concerns: %i[exportable importable filterable quick_filterable archivable restorable]
    resources :ports,             concerns: %i[exportable importable filterable quick_filterable archivable restorable]
    resources :buyers,            concerns: %i[exportable importable filterable quick_filterable archivable restorable]
    resources :container_details, concerns: %i[exportable importable filterable quick_filterable archivable restorable]
    resources :shipping_lines,    concerns: %i[exportable importable filterable quick_filterable archivable restorable]
    resources :freight_items,     concerns: %i[exportable importable filterable quick_filterable archivable restorable]
    resources :units,             concerns: %i[exportable importable filterable quick_filterable archivable restorable]
    resources :payment_types,     concerns: %i[exportable importable filterable quick_filterable archivable restorable]
    resources :charge_types,      concerns: %i[exportable importable filterable quick_filterable archivable restorable]
  end
end
