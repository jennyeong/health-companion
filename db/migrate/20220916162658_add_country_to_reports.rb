class AddCountryToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :country, :string
  end
end
