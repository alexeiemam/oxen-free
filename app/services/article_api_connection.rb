require 'net/http'
require 'json'

class ArticleApiConnection
  class ArticleFetchError < StandardError; end

  attr_reader :endpoint

  def initialize(endpoint: ARTICLE_API_ENDPOINT)
    @endpoint = endpoint
  end

  def fetch_articles
    response = Net::HTTP.get(@endpoint)
    JSON.parse(response)
  rescue StandardError => e
    raise ArticleFetchError
  end
end
