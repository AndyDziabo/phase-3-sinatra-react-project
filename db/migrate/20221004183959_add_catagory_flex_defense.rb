class AddCatagoryFlexDefense < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :catagory, :string
    add_column :favorites, :flex, :boolean
    add_column :favorites, :defense, :boolean
    add_column :favorites, :position, :string
  end
end
