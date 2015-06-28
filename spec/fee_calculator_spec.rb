require_relative '../lib/fee_calculator.rb'

describe FeeCalculator do
  it 'charges 1 dollar per item' do
    item1 = double(:item1, price: 15, weight: 3)
    item2 = double(:item2, price: 15, weight: 3)
    item3 = double(:item3, price: 15, weight: 3)

    expect(FeeCalculator.calculate([item1, item2, item3])).to eq 3
  end

  it 'adds 2-dollar fee for items over 10 lbs' do
    item1 = double(:item1, price: 15, weight: 3)
    item2 = double(:item2, price: 15, weight: 10)
    item3 = double(:item3, price: 15, weight: 11)

    expect(FeeCalculator.calculate([item1, item2, item3])).to eq 5
  end

  it 'adds a 4-dollar transportation fee for items over 100 dollars' do
    item1 = double(:item1, price: 100, weight: 3)
    item2 = double(:item2, price: 101, weight: 10)
    item3 = double(:item3, price: 15, weight: 1)

    expect(FeeCalculator.calculate([item1, item2, item3])).to eq 7
  end

  it 'discounts items with price fees' do
    item1 = double(:item1, price: 15, weight: 3)
    item2 = double(:item2, price: 101, weight: 3)
    item3 = double(:item3, price: 15, weight: 3)

    discount = double(:discount, item: item2, type: "no_price_bonus")

    expect(FeeCalculator.calculate([item1, item2, item3], [discount])).to eq 3
  end

  it 'discounts items with weight fees' do
    item1 = double(:item1, price: 15, weight: 50)
    item2 = double(:item2, price: 15, weight: 3)
    item3 = double(:item3, price: 15, weight: 3)

    discount = double(:discount, item: item1, type: "no_weight_bonus")

    expect(FeeCalculator.calculate([item1, item2, item3], [discount])).to eq 3
  end

  xit 'reduces fees by 2 dollars if the price is > 500' do
    item1 = double(:item1, price: 125, weight: 3)
    item2 = double(:item2, price: 125, weight: 3)
    item3 = double(:item3, price: 251, weight: 3)

    expect(FeeCalculator.calculate([item1, item2, item3])).to eq 13
  end
end
