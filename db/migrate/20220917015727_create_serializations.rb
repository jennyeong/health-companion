class CreateSerializations < ActiveRecord::Migration[7.0]
  def change
    create_table :serializations do |t|
      t.string :serial_num
      t.string :batch
      t.date :exp_date
      t.date :mfg_date
      t.references :medicine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
