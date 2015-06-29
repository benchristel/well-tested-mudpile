require_relative '../lib/fee_applier'

describe FeeApplier do
  describe 'when the fee applies' do
    before do
      fee = double(:fee)
      allow(fee).to receive(:applies?).and_return true
      allow(Fee).to receive(:of_type).and_return(fee)
    end

    it 'applies a $2 weight fee to the item' do
      fee = [0]
      FeeApplier.new(double(:item)).apply('weight', fee)
      expect(fee[0]).to eq 2
    end

    it 'applies a $4 price fee to the item' do
      fee = [0]
      FeeApplier.new(double(:item)).apply('price', fee)
      expect(fee[0]).to eq 4
    end

    it 'applies a $1 base fee to the item' do
      fee = [0]
      FeeApplier.new(double(:item)).apply('base', fee)
      expect(fee[0]).to eq 1
    end
  end

  describe 'when the fee does not apply' do
    before do
      fee = double(:fee)
      allow(fee).to receive(:applies?).and_return false
      allow(Fee).to receive(:of_type).and_return(fee)
    end

    it 'applies no weight fee to the item' do
      fee = [0]
      FeeApplier.new(double(:item)).apply('weight', fee)
      expect(fee[0]).to eq 0
    end

    it 'applies no price fee to the item' do
      fee = [0]
      FeeApplier.new(double(:item)).apply('price', fee)
      expect(fee[0]).to eq 0
    end

    it 'applies no base fee to the item' do
      fee = [0]
      FeeApplier.new(double(:item)).apply('base', fee)
      expect(fee[0]).to eq 0
    end
  end
end
