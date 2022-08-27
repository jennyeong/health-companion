class CreateMedicines < ActiveRecord::Migration[7.0]
  def change
    create_table :medicines do |t|
      t.string :name
      t.string :batch
      t.date :exp_date
      t.date :mfg_date
      t.string :manufacturer
      t.string :serial_num

      t.timestamps
    end
  end
end
