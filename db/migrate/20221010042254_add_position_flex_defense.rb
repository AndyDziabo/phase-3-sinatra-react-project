class AddPositionFlexDefense < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :position, :string
    add_column :teams, :flex, :boolean
    add_column :teams, :defense, :boolean
  end
end
