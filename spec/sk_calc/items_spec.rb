require 'spec_helper'

class LineItem
  include SK::Calc
  attr_accessor :price_single, :tax, :quantity, :discount
  calculates :item
end

class Doc
  include SK::Calc
  attr_accessor :price_total, :price_tax, :line_items, :precision
  calculates :items
end

describe SK::Calc, 'items calculations' do

  before :each do
    @i = LineItem.new
    @i.price_single = 10.0
    @i.discount = 0
    @i.quantity = 1
    @i.tax = 19.0

    @doc = Doc.new
    @doc.line_items = [@i]
  end

  it "calc net_total" do
    @doc.sum_items
    expect(@doc.net_total).to eq 10.0
  end

  it "calc gross_total" do
    @doc.sum_items
    expect(@doc.gross_total).to eq 11.90
  end

  it "sums totals" do
    @doc.sum_items
    expect(@doc.price_total).to eq 10.0
    expect(@doc.price_tax).to eq 1.90
  end

  it "sums items with tax as rational" do
    @i.price_single = 7142.857143
    @i.tax = BigDecimal('19.0')
    @doc.sum_items
    expect(@doc.price_total).to eq 7142.857143
    expect(@doc.price_tax).to eq 1357.142857
    expect(@doc.gross_total).to eq 8500.00
  end

  it "tax_grouped" do
    @i.price_single = 7142.857143
    @i.tax = BigDecimal('19.0')
    res = @doc.tax_grouped
    expect(res).to eq [[19.0, 1357.142857]]
  end


end