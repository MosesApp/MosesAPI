require 'api_constraints'

Rails.application.routes.draw do
  mount SabisuRails::Engine => "/"
  namespace :api, defaults: { format: :json },
                        constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :groups, :only =>[:show, :create]
    end
  end
end
