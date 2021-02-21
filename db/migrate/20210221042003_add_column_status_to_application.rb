class AddColumnStatusToApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :applications, :status, :integer, default: 1
  end
end
