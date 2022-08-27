class Medicine < ApplicationRecord
  validates :name, :batch, :exp_date, :mfg_date, :manufacturer, :serial_num, presence: true
  validates :serial_num, uniqueness: true
end
