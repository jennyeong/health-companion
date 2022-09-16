class RemoveMedNameFromReports < ActiveRecord::Migration[7.0]
  def change
    remove_column :reports, :med_name, :string
  end
end
