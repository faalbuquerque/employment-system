class AddColumnAdminToCollaborator < ActiveRecord::Migration[6.1]
  def change
    add_column :collaborators, :admin, :integer, default: 0, null: false
  end
end
