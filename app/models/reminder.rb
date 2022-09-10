class Reminder < ApplicationRecord
  belongs_to :user, optional: true
  has_many :medicine
  validates_presence_of :interval, :start_date, :end_date, :start_time, :end_time, :dosage, :med_name

  scope :sort_by_latest, -> { order(start_date: :asc, start_time: :asc) }
end
