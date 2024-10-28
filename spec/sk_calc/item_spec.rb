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
     expect(i.send(:conv_tax)).to eq 0
   end
   it 'conv_price_single' do
     i = ItemWithoutFields.new
     expect(i.send(:conv_price_single)).to eq 0
   end

   it 'rounds to max 6 conv_price_single' do
     i = ItemWithoutFields.new
     i.price_single = 1.12345678
     expect(i.send(:conv_price_single).to_f).to eq 1.123457
   end

   it 'conv_discount' do
     i = ItemWithoutFields.new
     expect(i.send(:conv_discount)).to eq 0
   end

   it 'conv_quantity' do
     i = ItemWithoutFields.new
     expect(i.send(:conv_quantity)).to eq 0
     expect(i.send(:conv_quantity)).to be_a Rational
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
      expect(@i.net_single).to eq 10.00
    end

    it "has gross_single" do
      expect(@i.gross_single).to eq 11.90
    end

    it "has total" do
      expect(@i.total).to eq 10.0
    end

    it "has net_total" do
      expect(@i.net_total).to eq 10.0
    end

    it "has gross_total" do
      expect(@i.gross_total).to eq 11.90
    end

    it "has net_total_base" do
      expect(@i.net_total_base).to eq 10.00
    end

    it "has tax_total" do
      expect(@i.tax_total).to eq 1.90
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
      expect(@i.total).to eq 12.605
    end

    it "has net_total" do
      expect(@i.net_total.to_f).to eq 12.61
    end

    it "has gross_total" do
      expect(@i.gross_total).to eq 15.0
    end

    it "has net_total_base" do
      expect(@i.net_total_base).to eq 12.605
    end
    it "has net_total" do
      expect(@i.net_total).to eq 12.61
    end

    it "has tax_total_base" do
      expect(@i.tax_total_base).to eq 2.39495
    end

    it "has tax_total" do
      expect(@i.tax_total).to eq 2.39
    end
  end

  describe 'calculates with mixed values' do

    it 'converts quantity to rationale' do
      i = LineItem.new
      i.price_single = 12345.123456
      i.quantity = BigDecimal.new("1.0")
      expect(i.total).to eq 12345.123456
      expect(i.total).to be_a Rational
    end
  end

end
