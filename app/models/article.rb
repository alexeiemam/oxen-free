class Article < ApplicationRecord
  # This has_many association is a Rails convention
  # to indicate that each Article is associated to many Like records
  # and provides convenient shorthand syntax to access these
  #
  # e.g.
  #
  # `an_article = Article.first`
  # `an_article.likes.count`
  # => 8
  has_many :likes

  # The below scopes permit collections/list of articles to be fetched
  # using shorthand syntax
  # that match particular criteria or appear in a certain order
  #
  # e.g.
  #
  # `Article.by_impressions`
  # returns all articles in order of their api reported impressions count
  scope :published,       -> { where("published_at <= ?", Time.current).order(api_created_at: :desc, api_id: :desc) }
  scope :by_publish_date, -> { order(api_created_at: :desc, api_id: :desc) }
  scope :by_expiry,       -> { order(api_expires_at: :asc) }
  scope :by_updated,      -> { order(api_updated_at: :desc)}
  scope :by_likes,        -> { order(api_like_count: :desc) }
  scope :by_views,        -> { order(api_view_count: :desc) }
  scope :by_impressions,  -> { order(api_impression_count: :desc) }
  scope :by_price,        -> { order(api_views: :desc) }
  scope :by_rating,       -> { order(api_views: :desc) }
  scope :by_distance,     -> { order(api_distance: :asc) }


  # This method returns the most recent local published_at date
  def self.last_checked_at
    maximum(:published_at)
  end

 # This method returns the most recent API-reported updated_at date
  def self.last_updated_at
    maximum(:api_updated_at)
  end


  # The API ID represents
  # the canonical identifier
  # for an article.
  # it must be unique
  validates_uniqueness_of :api_id

  # The API ID represents
  # the public identifier
  # for an article.
  # it is used in URLs
  # The .from_param and #to_param
  # methods enable this employing Rails conventions
  # in conjunction with config/routes.rb and app/controllers/articles_controller.rb
  def self.from_param(needle)
    find_by(api_id: needle)
  end
  def to_param
    api_id.to_s
  end

  # This method combines the count of local application likes
  # with the count of API-reported likes
  #
  # Caveat:
  #
  # In a more complete integration, it is assumed information regarding
  # likes would make it back to the API in some syncrhonisation event
  # and this method would cause double-counting.
  def total_likes
    (likes_count || 0) + (api_like_count || 0)
  end

end
