class AddColumnsToCandidate < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates, :name, :string
    add_column :candidates, :cpf, :string
    add_column :candidates, :telephone, :string
    add_column :candidates, :bio, :string
  end
end
