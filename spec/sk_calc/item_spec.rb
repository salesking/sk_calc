require 'spec_helper'

class LineItem
  include SK::Calc
  attr_accessor :price_single, :tax, :quantity, :discount
  calculates :item
end

describe SK::Calc, 'item calculations' do

  before :each do
    @i = LineItem.new
    @i.price_single = 10.0
    @i.discount = 0
    @i.quantity = 1
    @i.tax = 19.0
  end

  it "should calc net_single" do
    @i.net_single.should == 10.00
  end

  it "should calc gross_single" do
    @i.gross_single.should == 11.90
  end

  it "should calc total" do
    @i.total.should == 10.0
  end

  it "should calc net_total" do
    @i.net_total.should == 10.0
  end

  it "should calc gross_total" do
    @i.gross_total.should == 11.90
  end

end