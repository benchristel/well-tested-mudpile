require_relative '../lib/fee'

describe Fee::WeightFee do
  subject { Fee.of_type('weight') }

  describe '#applies?' do
    it "is true when the item's weight is greater than 10" do
      expect(subject.applies?(double weight: 11)).to be true
    end

    it "is false when the item's weight is less than 10" do
      expect(subject.applies?(double weight: 9)).to be false
    end
  end
end

describe Fee::PriceFee do
  subject { Fee.of_type('price') }

  describe '#applies?' do
    it "is true when the item's price is greater than 100" do
      expect(subject.applies?(double price: 101)).to be true
    end

    it "is false when the item's price is less than 99" do
      expect(subject.applies?(double price: 99)).to be false
    end
  end
end

describe Fee::BaseFee do
  subject { Fee.of_type('base') }

  describe '#applies?' do
    it "is true" do
      expect(subject.applies?(double)).to be true
    end
  end
end
