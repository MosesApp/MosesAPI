require 'api_constraints'

Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications, :authorizations
  end

  mount SabisuRails::Engine => "/"
  namespace :api, defaults: { format: :json },
                        constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resource :user, :only => [:show, :update, :destroy]
      resources :groups, :only =>[:index, :show, :create]
    end
  end
end
