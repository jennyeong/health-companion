class Medicine < ApplicationRecord

  validates :name, :batch, :exp_date, :mfg_date, :manufacturer, :serial_num, presence: true
  validates :serial_num, uniqueness: true

  has_one_attached :photo

  # has_and_belongs_to_many :reminders
end
