class AddTimeToReminder < ActiveRecord::Migration[7.0]
  def change
    add_column :reminders, :time_1, :time
    add_column :reminders, :time_2, :time
    add_column :reminders, :time_3, :time
    add_column :reminders, :time_4, :time
  end
end
