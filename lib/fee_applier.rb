require_relative './fee'

class FeeApplier

  FEE_AMOUNTS = {
    'weight' => 2,
    'price' => 4,
    'base' => 1,
  }

  def initialize(item)
    @item = item
  end

  def apply(type, fee)
    if Fee.of_type(type).applies?(@item)
      fee[0] += FEE_AMOUNTS[type]
    end

    self
  end
end
