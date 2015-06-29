require_relative './fee_applier'

class ItemFeeDiscountApplier
  attr_reader :item
  attr_reader :discounts

  def initialize(item, discounts)
    @item = item
    @discounts = discounts
  end

  def apply_fees(fee)
    apply_all_fees(fee)
    apply_weight_discounts(fee)
    apply_price_discounts(fee)
  end

  def apply_all_fees(fee)
    FeeApplier.new(item)
      .apply('weight', fee)
      .apply('price', fee)
      .apply('base', fee)
  end

  def apply_weight_discounts(fee)
    if Fee.of_type('weight').applies?(item)
      discounts.each do |discount|
        if discount.item == item && discount.type == 'no_weight_bonus'
          DiscountApplier.new(discount, fee).apply_fee_change
        end
      end
    end
  end

  def apply_price_discounts(fee)
    if Fee.of_type('price').applies?(item)
      discounts.each do |discount|
        if discount.item == item && discount.type == 'no_price_bonus'
          DiscountApplier.new(discount, fee).apply_fee_change
        end
      end
    end
  end
end
