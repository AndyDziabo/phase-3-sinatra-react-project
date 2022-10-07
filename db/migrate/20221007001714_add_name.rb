class AddName < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :team_name, :string
  end
end
