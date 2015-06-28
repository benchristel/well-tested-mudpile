class FeeCalculator
  def self.calculate(items, discounts = [])
    fee = [0]

    items.each do |item|
      fee[0] += 1
    end

    items.each do |item|
      FeeApplier.new(item).apply_fees(fee)

      if item.weight > 10
        discounts.each do |discount|
          if discount.item == item && discount.type == 'no_weight_bonus'
            DiscountApplier.new(discount, fee).apply_fee_change
          end
        end
      end

      if item.price > 100
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

class DiscountApplier
  def initialize(discount, fee, total_order = 0)
    @discount = discount
    @fee = fee
    @total_order = total_order
  end

  def apply_fee_change
    if @discount.nil?
      @fee[0] -= 2 if @total_order > 500
    else
      case @discount.type
      when 'no_weight_bonus'
        @fee[0] -= 2
      when 'no_price_bonus'
        @fee[0] -= 4
      end
    end
  end
end

class FeeApplier
  def initialize(item)
    @item = item
  end

  def apply_fees(fee)
    if @item.weight > 10
      fee[0] += 2
    end
    if @item.price > 100
      fee[0] += 4
    end
  end
end
