class AddDefaultToOnline < ActiveRecord::Migration[7.0]
  def change
    change_column :reports, :online, :boolean, default: false
  end
end
