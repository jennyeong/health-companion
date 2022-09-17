class Report < ApplicationRecord
  belongs_to :user
  belongs_to :medicine
  has_many_attached :photos

  validates :shop_name, :effects, :comments, presence: true
  validates :shop_location, :country, presence: { if: -> { shop_url.blank? } }
  validates :shop_url, presence: { if: -> { shop_location.blank? } }

  include PgSearch::Model
  pg_search_scope :search_by_shop_name_and_shop_location,
  against: [ :shop_name, :shop_location, :shop_url, :med_name ],
  using: {
    tsearch: { prefix: true }
  }
end
