class CreateProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.string :message
      t.decimal :wage
      t.date :date_init
      t.integer :status, default: 1
      t.references :application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
