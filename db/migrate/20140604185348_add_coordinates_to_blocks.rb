class AddCoordinatesToBlocks < ActiveRecord::Migration[4.2]
  def change
    add_column :blocks, :lat, :decimal, { precision: 18, scale: 15 }
    add_column :blocks, :long, :decimal, { precision: 18, scale: 15 }
  end
end
