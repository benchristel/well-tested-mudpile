require_relative '../lib/item_fee_discount_applier'

describe ItemFeeDiscountApplier do
  let(:fee) { double :fee }
  let(:item) { double :item }
  let(:discounts) { [] }
  subject { ItemFeeDiscountApplier.new(item, discounts) }

  describe '#apply_all_fees' do
    it 'uses the FeeApplier' do
      fee_applier = double :fee_applier
      allow(FeeApplier).to receive(:new).with(item).and_return(fee_applier)
      allow(fee_applier).to receive(:apply).and_return(fee_applier)

      subject.apply_all_fees(fee)

      expect(fee_applier).to have_received(:apply).with('weight', fee).once
      expect(fee_applier).to have_received(:apply).with('price', fee).once
      expect(fee_applier).to have_received(:apply).with('base', fee).once
    end
  end

  describe '#apply_weight_discounts' do
    before do
      fee_of_type = double
      allow(Fee).to receive(:of_type).with('weight').and_return fee_of_type
      allow(fee_of_type).to receive(:applies?).and_return fees_apply?
    end

    describe 'when weight fees apply' do
      let(:fees_apply?) { true }

      describe 'when there is a discount on weight fees' do
        let(:discounts) { [double(item: item, type: 'no_weight_bonus')] }

        it 'applies the discount' do
          discount_applier = double :discount_applier
          allow(DiscountApplier).to receive(:new).with(discounts[0], fee).and_return(discount_applier)
          allow(discount_applier).to receive :apply_fee_change

          subject.apply_weight_discounts(fee)

          expect(discount_applier).to have_received :apply_fee_change
        end
      end

      describe 'when there is no discount on weight fees' do
        let(:discounts) { [] }

        it 'applies no discount' do
          allow(DiscountApplier).to receive(:new)

          subject.apply_weight_discounts(fee)

          expect(DiscountApplier).not_to have_received :new
        end
      end
    end

    describe 'when weight fees do not apply' do
      let(:fees_apply?) { false }

      it 'applies no discount' do
        allow(DiscountApplier).to receive(:new)

        subject.apply_weight_discounts(fee)

        expect(DiscountApplier).not_to have_received :new
      end
    end
  end

  describe '#apply_price_discounts' do
    before do
      fee_of_type = double
      allow(Fee).to receive(:of_type).with('price').and_return fee_of_type
      allow(fee_of_type).to receive(:applies?).and_return fees_apply?
    end

    describe 'when price fees apply' do
      let(:fees_apply?) { true }

      describe 'when there is a discount on price fees' do
        let(:discounts) { [double(item: item, type: 'no_price_bonus')] }

        it 'applies the discount' do
          discount_applier = double :discount_applier
          allow(DiscountApplier).to receive(:new).with(discounts[0], fee).and_return(discount_applier)
          allow(discount_applier).to receive :apply_fee_change

          subject.apply_price_discounts(fee)

          expect(discount_applier).to have_received :apply_fee_change
        end
      end

      describe 'when there is no discount on price fees' do
        let(:discounts) { [] }

        it 'applies no discount' do
          allow(DiscountApplier).to receive(:new)

          subject.apply_price_discounts(fee)

          expect(DiscountApplier).not_to have_received :new
        end
      end
    end

    describe 'when price fees do not apply' do
      let(:fees_apply?) { false }

      it 'applies no discount' do
        allow(DiscountApplier).to receive(:new)

        subject.apply_price_discounts(fee)

        expect(DiscountApplier).not_to have_received :new
      end
    end
  end
end
