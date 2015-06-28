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
