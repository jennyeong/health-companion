class MedicineCleanUp < ActiveRecord::Migration[7.0]
  def change
    remove_column :medicines, :batch, :string
    remove_column :medicines, :exp_date, :date
    remove_column :medicines, :mfg_date, :date
    remove_column :medicines, :serial_num, :string
  end
end
