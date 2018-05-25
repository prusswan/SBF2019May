class AddCoordinatesToBlocks < ActiveRecord::Migration
  def change
    add_column :blocks, :lat, :decimal, { precision: 18, scale: 15 }
    add_column :blocks, :long, :decimal, { precision: 18, scale: 15 }
  end
end
