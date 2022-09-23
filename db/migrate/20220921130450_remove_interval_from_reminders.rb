class RemoveIntervalFromReminders < ActiveRecord::Migration[7.0]
  def change
    remove_column :reminders, :interval, :integer
  end
end
