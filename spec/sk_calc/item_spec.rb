require 'spec_helper'

class LineItem
  include SK::Calc
  attr_accessor :price_single, :tax, :quantity, :discount
  calculates :item
end

class ItemWithoutFields
  include SK::Calc
  attr_accessor :price_single, :quantity
  calculates :item
end

describe SK::Calc do

 describe 'private convert methods' do
   it 'conv_tax' do
     i = ItemWithoutFields.new
     i.send(:conv_tax).should == 0
   end
   it 'conv_price_single' do
     i = ItemWithoutFields.new
     i.send(:conv_price_single).should == 0
   end

   it 'rounds to max 6 conv_price_single' do
     i = ItemWithoutFields.new
     i.price_single = 1.12345678
     i.send(:conv_price_single).to_f.should == 1.123457
   end

   it 'conv_discount' do
     i = ItemWithoutFields.new
     i.send(:conv_discount).should == 0
   end

   it 'conv_quantity' do
     i = ItemWithoutFields.new
     i.send(:conv_quantity).should == 0
     i.send(:conv_quantity).should be_a Rational
   end
 end

 describe 'item calculations' do

    before :each do
      @i = LineItem.new
      @i.price_single = 10.0
      @i.discount = 0
      @i.quantity = 1
      @i.tax = 19.0
    end

    it "has net_single" do
      @i.net_single.should == 10.00
    end

    it "has gross_single" do
      @i.gross_single.should == 11.90
    end

    it "has total" do
      @i.total.should == 10.0
    end

    it "has net_total" do
      @i.net_total.should == 10.0
    end

    it "has gross_total" do
      @i.gross_total.should == 11.90
    end

    it "has net_total_base" do
      @i.net_total_base.should == 10.00
    end

    it "has tax_total" do
      @i.tax_total.should == 1.90
    end
  end

  describe 'calculates 15.00 gross price' do

    before :each do
      @i = LineItem.new
      @i.price_single = 12.605
      @i.discount = 0
      @i.quantity = 1
      @i.tax = 19.0
    end

    it "has total" do
      @i.total.should == 12.605
    end

    it "has net_total" do
      @i.net_total.to_f.should == 12.61
    end

    it "has gross_total" do
      @i.gross_total.should == 15.0
    end

    it "has net_total_base" do
      @i.net_total_base.should == 12.605
    end
    it "has net_total" do
      @i.net_total.should == 12.61
    end

    it "has tax_total_base" do
      @i.tax_total_base.should == 2.39495
    end

    it "has tax_total" do
      @i.tax_total.should == 2.39
    end
  end

  describe 'calculates with mixed values' do

    it 'converts quantity to rationale' do
      i = LineItem.new
      i.price_single = 12345.123456
      i.quantity = BigDecimal.new("1.0")
      i.total.should == 12345.123456
      i.total.should be_a Rational
    end
  end

end
