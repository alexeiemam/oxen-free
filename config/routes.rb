# frozen_string_literal: true

Rails.application.routes.draw do
  get 'articles/:api_id', controller: 'articles', action: 'show', :as => :article

  root 'articles#index'
end
