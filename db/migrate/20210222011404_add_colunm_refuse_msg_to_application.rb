class AddColunmRefuseMsgToApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :applications, :refuse_msg, :string, default: nil
  end
end
