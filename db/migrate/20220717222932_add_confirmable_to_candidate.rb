class AddConfirmableToCandidate < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates, :confirmation_token, :string
    add_column :candidates, :confirmed_at, :datetime
    add_column :candidates, :confirmation_sent_at, :datetime
    add_column :candidates, :unconfirmed_email, :string
  end
end
