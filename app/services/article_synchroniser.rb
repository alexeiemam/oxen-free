class ArticleSynchroniser

  def initialize

  end

  def current_articles
    @current_articles ||= ArticleApiConnection.new.fetch_articles
  end

  def formatted_articles
    @formatted_articles ||=
      current_articles.map do |api_article|
        # t.integer :api_id, unique: true, index: true
        # t.integer :api_collection_id, unique: true, index: true
        # t.string :api_status, index: true
        # t.string :api_section, index: true
        # t.integer :api_view_count, index: true
        # t.integer :api_like_count, index: true
        # t.integer :api_impression_count, index: true
        # t.integer :api_price, index: true
        # t.integer :api_user_rating_number, index: true
        # t.integer :api_user_rating_count, index: true
        # t.integer :api_distance, index: true
        # t.column :api_location, :point
        # t.timestamp :api_created_at, index: true
        # t.timestamp :api_updated_at, index: true
        # t.timestamp :api_expiry_at, index: true

        {
          source: api_article,
          api_id: api_article['id'],
          api_collection_id:  api_article.dig('collection','id'),
          api_status: api_article['status'],
          api_section: api_article['section'],
          api_view_count: api_article.dig('reactions','views'),
          api_like_count: api_article.dig('reactions','likes'),
          api_impression_count: api_article.dig('reactions','impressions'),
          api_price: api_article.dig('value','price'),
          api_user_rating_number: api_article.dig('user','rating','number'),
          api_user_rating_count: api_article.dig('value','rating', 'rating'),
          # api_location: ,
          api_distance: api_article.dig('location','distance'),
          api_created_at: Time.parse(api_article['created_at']),
          api_updated_at: Time.parse(api_article['updated_at']),
          api_expires_at: Time.parse(api_article['expiry']),
        }
      end
  end

  def create!
    created_articles = Article.create!(formatted_articles)
    Article.where(id: formatted_articles.map{|art| art[:api_id]}).update_all(published_at: Time.current)
  end
end
