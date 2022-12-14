class Reminder < ApplicationRecord
  belongs_to :user
  belongs_to :medicine
  validates_presence_of  :start_date, :end_date, :time_1 ,:dosage
  #validates_numericality_of  only_integer: true, greater_than_or_equal_to: 6

  scope :sort_by_latest, -> { order(start_date: :asc) }

  def next_due_timestamp
    next_due = nil
    current_time = Time.current.strftime("%H:%M")
    available_times = [time_1, time_2, time_3, time_4].compact.sort_by{|t| t&.strftime("%H:%M")}
    available_times.each do |medicine_time|
      if current_time > medicine_time&.strftime("%H:%M")
        next
      else
        next_due = Time.new(Time.current.year, Time.current.month, Time.current.day, medicine_time.hour, medicine_time.min, medicine_time.sec, 8*3600).to_datetime
        break
      end
    end
    next_due
  end

  def self.active_reminders_for user_id
    Reminder.where(user_id: user_id).map{|s| s if s.next_due_timestamp.present?}.compact.sort_by{|s| s.next_due_timestamp}
  end

   def self.completed_reminders_for user_id
    Reminder.where(user_id: user_id).map{|s| s if !s.next_due_timestamp.present?}.compact
  end

end
