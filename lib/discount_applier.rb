class DiscountApplier
  def initialize(discount, fee, order_total = 0)
    @discount = discount
    @fee = fee
    @order_total = order_total
  end

  def apply_fee_change
    if @discount.nil?
      @fee[0] -= 2 if @order_total > 500
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
