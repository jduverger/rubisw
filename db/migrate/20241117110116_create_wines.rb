class CreateWines < ActiveRecord::Migration[8.0]
  def change
    create_table :wines do |t|
      t.string :nom
      t.string :couleur
      t.string :producteur
      t.string :cru
      t.string :millesime
      t.string :regions
      t.string :cepage
      t.integer :qte
      t.string :estimation
      t.string :evaluation
      t.timestamps
    end
  end
end
