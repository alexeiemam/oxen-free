require 'net/http'
require 'json'

class ArticleApiConnection
  # This error class is intended to provide a means
  # for consumers of the ArticleApiConnection to have a named
  # error to rescue from /
  #
  # e.g.
  #
  # `ArticleApiConnection.new.fetch_bloomintons rescue ArticleApiConnection`
  # would helpfully error (indicating the source of the problem is the method name)
  #
  # vs.
  #
  # `ArticleApiConnection.new.fetch_bloomintons rescue StandardError`
  # which would mask the issue
  class ArticleFetchError < StandardError; end

  attr_reader :endpoint

  def initialize(endpoint: ARTICLE_API_ENDPOINT)
    @endpoint = endpoint
  end

  # This method fetches data from the specified endpoint
  # and parses the response data as JSON
  #
  # A JSON response is assumed.
  # In a real world scenario, it is likely there would be API authentication
  # and request pagination requirements
  def fetch_articles
    response = Net::HTTP.get(@endpoint)
    JSON.parse(response)
  rescue StandardError => e
    raise ArticleFetchError
  end
end
