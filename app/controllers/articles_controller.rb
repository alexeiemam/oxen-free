class ArticlesController < ApplicationController
  # GET /articles or /articles.json

  # @todo
  # Add Pagination

  # @todo
  # Add Sorting

  # @todo
  # Add Filtering

  # @todo
  # Protect API and app from overzealous fetches due to site popularity
  # Background record updates only
  # e.g.
  # - authenticated postback route from API source to trigger synchronisation
  # - periodic background fetching by app polling

  # @todo
  # Realtime updates to list using turbo streams
  # For Like Count change, For background Article attribute change, etc.

  def index
    # Per requirement, this method refreshes its article store from the API
    # on each request
    # Per @todo above, for DOS resilience and performance, preference is for background
    # updates (not user triggered)
    ArticleSynchroniser.new.sync_and_publish! unless params.has_key?(:allow_stale)
    @articles = Article.published
  end

  def show
    @article = Article.from_param(params.require(:api_id))
  end
end
