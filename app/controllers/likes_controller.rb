class LikesController < ApplicationController
  before_action :set_article

  def create
    @article.likes.create!
    # @todo
    # Determine why redirect_back to index does not update the like count on an article
    # but redirect to article does
    # redirect_back_or_to(url_for(@article))
    redirect_to (url_for(@article))
  end

  private
    def set_article
      @article = Article.from_param(params[:api_id])
    end
end
