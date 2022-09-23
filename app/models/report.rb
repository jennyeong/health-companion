class Report < ApplicationRecord
  belongs_to :user
  belongs_to :medicine
  has_many_attached :photos

  validates :shop_name, :effects, :comments, presence: true
  validates :shop_location, :country, presence: { if: -> { shop_url.blank? } }
  validates :shop_url, presence: { if: -> { shop_location.blank? } }

  geocoded_by :shop_location
  after_validation :geocode, if: :will_save_change_to_shop_location?

  include PgSearch::Model
  pg_search_scope :global_search,
  against: [ :shop_name, :shop_location, :shop_url, :country ],
    associated_against: {
      medicine: [ :name, :manufacturer ]
  },
  using: {
    tsearch: { prefix: true }
  }
end
