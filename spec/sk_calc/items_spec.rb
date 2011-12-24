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

  it "should calc net_total" do
    @doc.sum_items
    @doc.net_total.should == 10.0
  end

  it "should calc gross_total" do
    @doc.sum_items
    @doc.gross_total.should == 11.90
  end

  it "should sum totals" do
    @doc.sum_items
    @doc.price_total.should == 10.0
    @doc.price_tax.should == 1.90
  end

end