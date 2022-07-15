class Article < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :article_synchronisation_change_logs

  scope :published, -> { where("published_at <= ? AND api_id IS NOT NULL", Time.current) }
  scope :by_publish_date, -> { order(published_at: :desc, api_id: :desc) }
  scope :by_likes, -> { order(api_likes: :desc) }
  scope :by_views, -> { order(api_views: :desc) }
  scope :by_expiry, -> { order(api_views: :desc) }
  scope :by_price, -> { order(api_views: :desc) }
  scope :by_rating, -> { order(api_views: :desc) }
  scope :by_impressions, -> { order(api_views: :desc) }
  # scope :by_distance, -> {}

  validates_uniqueness_of :api_id
  def self.from_param(needle)
    find_by(api_id: needle)
  end
  def to_param
    api_id.to_s
  end

  def total_likes
    likes.count + api_likes_total
  end

  def api_likes_total
    (source.dig('reactions', 'likes') || 0)
  end
end
