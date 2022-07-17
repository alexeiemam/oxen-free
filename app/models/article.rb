class Article < ApplicationRecord
  has_many :likes

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

 def self.last_checked_at
   maximum(:published_at)
 end

 def self.last_updated_at
   maximum(:api_updated_at)
 end

  def self.from_param(needle)
    find_by(api_id: needle)
  end
  def to_param
    api_id.to_s
  end

  validates_uniqueness_of :api_id

  def total_likes
    likes.count + api_like_count
  end

end
