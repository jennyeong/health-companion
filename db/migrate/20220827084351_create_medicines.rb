class CreateMedicines < ActiveRecord::Migration[7.0]
  def change
    create_table :medicines do |t|
      t.text :med_name
      t.text :batch
      t.date :exp_date
      t.date :mfg_date
      t.text :manufacturer
      t.text :seriel_num

      t.timestamps
    end
  end
end
