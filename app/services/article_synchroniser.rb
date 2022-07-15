class ArticleSynchroniser

  def initialize

  end

  def current_articles
    @current_articles ||= ArticleApiConnection.new.fetch_articles
  end

  def formatted_articles
    @formatted_articles ||=
      current_articles.map do |api_article|
        {
          source: api_article,
          api_id: api_article['id']
        }
      end
  end

  def create!
    created_articles = Article.create!(formatted_articles)
    Article.where(id: formatted_articles.map{|art| art[:api_id]}).update_all(published_at: Time.current)
  end
end
