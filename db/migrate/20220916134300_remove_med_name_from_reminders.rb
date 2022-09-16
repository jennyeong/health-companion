class RemoveMedNameFromReminders < ActiveRecord::Migration[7.0]
  def change
    remove_column :reminders, :med_name, :string
  end
end
