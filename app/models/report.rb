class Report < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  include PgSearch::Model
  pg_search_scope :search_by_shop_name_and_shop_location,
  against: [ :shop_name, :shop_location, :shop_url, :med_name ],
  using: {
    tsearch: { prefix: true }
  }
end
