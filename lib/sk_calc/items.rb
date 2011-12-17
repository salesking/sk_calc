# Calculate totals for a multiple items .. in a document
# Including class MUST respond to:
# - price_total
# - precision
# - price_tax
module SK::Calc::Items

  # Gross total always rounded to 2 decimals
  def gross_total
    val = (net_total || 0) + conv_tax
    val.round(2)
  end

  # Net total rounded to 2 decimals, the taxation base
  def net_total
    net_total_base.round(2)
  end

  # Rounded net total to document presicion. Defaults to 2 decimals
  # Should only be used when decimal settings are set > 2, so one can see the base
  # sum of the line items before rounded net total is taxed
  def net_total_base
   conv_price_total.round( precision || 2 )
  end

  # Rounded price_tax to 2 decimals
  def tax_total
    conv_tax.round(2)
  end

  private

  # Init price single with 0 if nil and cast to BigDecimal
  # == Return
  # <BigDecimal>
  def conv_price_total
    to_bd(price_total || 0)
  end

  # Init tax with 0 if nil and cast to BigDecimal
  # == Return
  # <BigDecimal>
  def conv_tax
    to_bd(price_tax || 0)
  end
  
  # Cast a val to BigDecimal
  # == Return
  # <BigDecimal>
  def to_bd(val)    
    val.is_a?(BigDecimal) ? val : BigDecimal.new("#{val}") 
  end

end