class AddGeocodeResultToBlocks < ActiveRecord::Migration
  def change
    add_column :blocks, :geocode_result, :json
  end
end
