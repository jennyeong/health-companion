class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :shop_name
      t.string :shop_location
      t.string :shop_url
      t.references :user, null: false, foreign_key: true
      t.text :effects
      t.text :comments
      t.string :med_name
      t.boolean :online

      t.timestamps
    end
  end
end
