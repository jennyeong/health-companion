class CreateReminders < ActiveRecord::Migration[7.0]
  def change
    create_table :reminders do |t|

      t.integer :interval
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.integer :dosage
      t.text :med_name
      t.text :description
      t.references :user, foreign_key: true
      t.references :medicine, foreign_key: true

      t.timestamps
    end
  end
end
