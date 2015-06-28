class FeeApplier
  def initialize(item)
    @item = item
  end

  def apply(type, fee)
    if Fee.of_type(type).applies?(@item)
      if type == 'weight'
        fee[0] += 2
      end

      if type == 'price'
        fee[0] += 4
      end

      if type == 'base'
        fee[0] += 1
      end
    end

    self
  end
end
