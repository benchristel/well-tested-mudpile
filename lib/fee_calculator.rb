require_relative './discount_applier'
require_relative './item_fee_discount_applier'

class FeeCalculator
  def self.calculate(items, discounts = [])
    fee = [0]

    items.each do |item|
      ItemFeeDiscountApplier.new(item, discounts).apply_fees(fee)
    end

    DiscountApplier.new(nil, fee, items.map(&:price).inject(&:+)).apply_fee_change

    fee[0]
  end
end
