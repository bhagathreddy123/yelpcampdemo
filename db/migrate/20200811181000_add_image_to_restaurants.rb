class AddImageToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :image, :json
  end
end
