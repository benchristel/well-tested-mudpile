require_relative './fee_applier'
require_relative './discount_applier'
require_relative './fee'

class FeeCalculator
  def self.calculate(items, discounts = [])
    fee = [0]

    items.each do |item|
      FeeApplier.new(item)
        .apply('weight', fee)
        .apply('price', fee)
        .apply('base', fee)

      if Fee.of_type('weight').applies?(item)
        discounts.each do |discount|
          if discount.item == item && discount.type == 'no_weight_bonus'
            DiscountApplier.new(discount, fee).apply_fee_change
          end
        end
      end

      if Fee.of_type('price').applies?(item)
        discounts.each do |discount|
          if discount.item == item && discount.type == 'no_price_bonus'
            DiscountApplier.new(discount, fee).apply_fee_change
          end
        end
      end
    end

    DiscountApplier.new(nil, fee, items.map(&:price).inject(&:+)).apply_fee_change

    fee[0]
  end
end
