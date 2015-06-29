require_relative '../lib/discount_applier'

describe DiscountApplier do
  describe 'with a discount' do
    describe 'with no_weight_bonus' do
      it 'applies a $2 discount' do
        discount = double(:discount, type: 'no_weight_bonus')
        fee = [0]
        DiscountApplier.new(discount, fee).apply_fee_change
        expect(fee[0]).to eq -2
      end
    end

    describe 'with no_price_bonus' do
      it 'applies a $4 discount' do
        discount = double(:discount, type: 'no_price_bonus')
        fee = [0]
        DiscountApplier.new(discount, fee).apply_fee_change
        expect(fee[0]).to eq -4
      end
    end
  end

  describe 'with an order total' do
    describe 'when the order_total is less than 500' do
      it 'applies no discounts' do
        fee = [0]
        DiscountApplier.new(nil, fee, 499).apply_fee_change
        expect(fee[0]).to eq 0
      end
    end

    describe 'when the order_total is greater than 500' do
      it 'applies a $2 discount' do
        fee = [0]
        DiscountApplier.new(nil, fee, 501).apply_fee_change
        expect(fee[0]).to eq -2
      end
    end
  end
end
