class Unit
  def address
    self.block.address
  end

  def price_per_area
    price * 1.0 / area
  end
end
