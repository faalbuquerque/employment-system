class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :logo
      t.string :address
      t.string :cnpj
      t.string :site

      t.timestamps
    end
  end
end
