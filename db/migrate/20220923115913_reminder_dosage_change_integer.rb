class ReminderDosageChangeInteger < ActiveRecord::Migration[7.0]
  def change
    change_column(:reminders, :dosage, :string)
  end
end
