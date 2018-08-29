class AddGeocodeResultToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_column :blocks, :geocode_result, :json
  end
end
