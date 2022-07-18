class ArticleSynchroniser
  # This class handles the business of synchronising article data
  # between the API and the local data store

  class ArticleFetcherUnsupportedError < StandardError; end
  attr_reader :article_fetcher

  def initialize(article_fetcher: ArticleApiConnection.new)
    @article_fetcher = article_fetcher
    raise ArticleFetcherUnsupportedError unless article_fetcher.respond_to?(:fetch_articles)
  end

  # The `sync_and_publish!`` method
  #
  # - Fetches remote articles
  # - Unpublishes any existing local articles that aren't part of the set of remote articles
  # - Creates or Updates in the local datastore
  # - Publishes any created or updated local articles
  def sync_and_publish!
    return unpublishable_local_articles.update_all(published_at: nil) if formatted_article_payloads.empty?
    Article.transaction do
      # Unpublish articles not in latest api fetch
      unpublishable_local_articles.update_all(published_at: nil)
      # Update or create records for articles in latest api fetch
      Article.upsert_all(formatted_article_payloads, unique_by: :api_id)
      # Publish records in latest api fetch
      updateable_local_articles.update_all(published_at: Time.current)
    end
  end

  private

    def current_remote_articles
      @current_remote_articles ||= article_fetcher.fetch_articles
    end

    def current_remote_article_ids
      @current_remote_article_ids ||= current_remote_articles.map {|art| art['id']}
    end

    def updateable_local_articles
      @updateable_local_articles ||= Article.where(api_id: current_remote_article_ids)
    end

    def unpublishable_local_articles
      @unpublishable_local_articles ||= Article.where.not(api_id: current_remote_article_ids)
    end

    # The `formatted_article_payloads` method
    # formats article data from the API into attributes
    # for local article records
    #
    # i.e. it flattens data that has behavioural significance and stores the rest
    # unstructured
    def formatted_article_payloads
      @formatted_article_payloads ||=
        current_remote_articles.map do |api_article|
          {
            source: api_article,
            # Interesting fields we may want to filter on or order by
            title: api_article['title'],
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
            api_created_at: (Time.parse(api_article['created_at']) if api_article['created_at'].present?),
            api_updated_at: (Time.parse(api_article['updated_at']) if api_article['updated_at'].present?),
            api_expires_at: (Time.parse(api_article['expiry']) if api_article['expiry'].present?),
          }
        end
    end

end
