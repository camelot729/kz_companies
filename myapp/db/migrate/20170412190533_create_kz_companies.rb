class KzCompany < ActiveRecord::Migration[5.0]
  def change
    create_table :kz_companies do |t|
      t.string :bin_code
      t.string :okpo_code
      t.string :full_name_of_the_organization
      t.string :date_of_organization
      t.integer :main_oked
      t.string :name_of_main_activity
      t.string :secondary_oked
      t.integer :krp_code
      t.string :krp_name
      t.string :kato_code
      t.string :name_of_locality
      t.string :legal_address
      t.string :full_name , foreign_key:

      t.timestamps
    end
  end
end
