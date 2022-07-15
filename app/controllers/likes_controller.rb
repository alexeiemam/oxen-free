class LikesController < ApplicationController
  before_action :set_article

  def create
    @article.likes.create!
    redirect_back_or_to(url_for(@article))
  end

  private
    def set_article
      @article = Article.from_param(params[:api_id])
    end
end
