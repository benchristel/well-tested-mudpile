class FeeCalculator
  def self.calculate(items, discounts = [])
    fee = [0]

    items.each do |item|
      fee[0] += 1
    end

    items.each do |item|
      if item.weight > 10
        fee[0] += 2

        discounts.each do |discount|
          if discount.item == item && discount.type == 'no_weight_bonus'
            DiscountApplier.new(discount, fee).apply_fee_change
          end
        end
      end
    end
    items.each do |item|
      if item.price > 100
        fee[0] += 4

        discounts.each do |discount|
          if discount.item == item && discount.type == 'no_price_bonus'
            DiscountApplier.new(discount, fee).apply_fee_change
          end
        end
      end
    end
    fee[0]
  end
end

class DiscountApplier
  def initialize(discount, fee)
    @discount = discount
    @fee = fee
  end

  def apply_fee_change
    case @discount.type
    when 'no_weight_bonus'
      @fee[0] -= 2
    when 'no_price_bonus'
      @fee[0] -= 4
    end
  end
end
