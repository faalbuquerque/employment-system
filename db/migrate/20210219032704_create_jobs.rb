class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title_job
      t.string :description
      t.decimal :salary_range
      t.integer :level, default: 2
      t.string :requisite
      t.date :date_limit
      t.integer :quantity
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
