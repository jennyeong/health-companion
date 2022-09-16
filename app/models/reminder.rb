class Reminder < ApplicationRecord
  belongs_to :user
  belongs_to :medicine
  validates_presence_of :interval, :start_date, :end_date, :start_time, :end_time, :dosage
  validates_numericality_of :interval, only_integer: true, greater_than_or_equal_to: 6

  scope :sort_by_latest, -> { order(start_date: :asc, start_time: :asc) }

  def next_due_timestamp
    start_datetime =  DateTime.new(start_date.year, start_date.month, start_date.day, start_time.hour, start_time.min, start_time.sec).in_time_zone
    end_datetime =  DateTime.new(end_date.year, end_date.month, end_date.day, end_time.hour, end_time.min, end_time.sec).in_time_zone
    next_due = nil
    if DateTime.current > start_datetime && DateTime.current < end_datetime
      segments = ((24/self.interval).to_i)
      next_due = DateTime.current.beginning_of_day
      segments.times do |i|
        next_due = next_due + interval.hours
        break if DateTime.current < next_due
      end
    end
    next_due
  end

  def time_intervals
    segments = ((24/self.interval).to_i)
    time_arr = []
    next_due = DateTime.current.beginning_of_day
    segments.times do |i|
      next_due = next_due + interval.hours
      time_arr.push(next_due)
    end
    time_arr
  end
end
