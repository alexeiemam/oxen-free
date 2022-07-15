class SynchronisationEvent < ApplicationRecord
  has_many :article_synchronisation_change_logs

  scope :completed, -> { where("completed_at <= ?", Time.current).order(completed_at: :desc) }

end
