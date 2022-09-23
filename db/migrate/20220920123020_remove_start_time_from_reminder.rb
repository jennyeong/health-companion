class RemoveStartTimeFromReminder < ActiveRecord::Migration[7.0]
  def change
    remove_column :reminders, :start_time, :string
    remove_column :reminders, :end_time, :string
  end
end
