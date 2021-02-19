class AddColumnCompanyToJobs < ActiveRecord::Migration[6.1]
  def change
    add_reference :jobs, :company, null: false, foreign_key: true
  end
end
