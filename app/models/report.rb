class Report < ApplicationRecord
  belongs_to :user
  belongs_to :medicine
  has_many_attached :photos

  validates :shop_name, :effects, :comments, presence: true
  validates :shop_location, :country, presence: { if: -> { shop_url.blank? } }
  validates :shop_url, presence: { if: -> { shop_location.blank? } }

  include PgSearch::Model
  pg_search_scope :global_search,
  against: [ :shop_name, :shop_location, :shop_url ],
    associated_against: {
      medicine: [ :name, :manufacturer ]
  },
  using: {
    tsearch: { prefix: true }
  }
end
