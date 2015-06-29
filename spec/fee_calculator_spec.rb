require_relative '../lib/fee_calculator.rb'

describe FeeCalculator do
  it 'charges 1 dollar per item' do
    items = [
      double(price: 105, weight: 30),
      double(price: 3, weight: 5),
      double(price: 512, weight: 10),
      double(price: 68, weight: 11),
    ]

    discounts = [
      double(item: items[0], type: 'no_weight_bonus'),
      double(item: items[2], type: 'no_price_bonus'),
    ]

    expect(FeeCalculator.calculate(items, discounts)).to eq 8
  end
end
