class ArticlesController < ApplicationController

  # GET /articles or /articles.json
  def index
    @articles = Article.published
  end

  def show
    @article = Article.from_param(params[:api_id])
  end
end
