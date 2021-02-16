class AddColumnCompanyToCollaborator < ActiveRecord::Migration[6.1]
  def change
    add_reference :collaborators, :company, null: false, foreign_key: true
  end
end
