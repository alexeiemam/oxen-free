class ArticlesController < ApplicationController

  # GET /articles or /articles.json
  def index
    @articles = Article.published
  end

  def show
    @article = Article.from_param(params.require(:api_id))
  end
end
