class Medicine < ApplicationRecord
  validates :name, :manufacturer, presence: true

  has_many :serializations, dependent: :destroy
  has_one_attached :photo

  # has_and_belongs_to_many :reminders
end
