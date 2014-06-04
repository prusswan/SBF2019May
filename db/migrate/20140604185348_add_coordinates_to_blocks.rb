class AddCoordinatesToBlocks < ActiveRecord::Migration
  def change
    add_column :blocks, :lat, :float
    add_column :blocks, :long, :float
  end
end
