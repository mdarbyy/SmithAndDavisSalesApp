class AddLastLoggedInToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :last_logged_in, :datetime
  end
end
