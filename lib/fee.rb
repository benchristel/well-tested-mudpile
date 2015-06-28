class Fee
  def self.of_type(type)
    if type == 'weight'
      WeightFee.new
    elsif type == 'price'
      PriceFee.new
    else
      BaseFee.new
    end
  end

  class WeightFee
    def applies?(item)
      item.weight > 10
    end
  end

  class PriceFee
    def applies?(item)
      item.price > 100
    end
  end

  class BaseFee
    def applies?(item)
      true
    end
  end
end
