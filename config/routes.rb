# frozen_string_literal: true

Rails.application.routes.draw do
  get 'articles/:api_id', controller: 'articles', action: 'show', :as => :article
  post 'articles/:api_id/like',  controller: 'likes', action: 'create', :as => :article_likes

  root 'articles#index'
end
