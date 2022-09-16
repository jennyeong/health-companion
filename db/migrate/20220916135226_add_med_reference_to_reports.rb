class AddMedReferenceToReports < ActiveRecord::Migration[7.0]
  def change
    add_reference :reports, :medicine, foreign_key: true
  end
end
