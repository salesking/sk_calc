# Helper methods to
# - convert empty or integer values into BigDecimals
module SK::Calc::Helper

  private

  # Init price single with 0 if nil and cast to BigDecimal
  # == Return
  # <BigDecimal>
  def conv_price_single
    to_bd(price_single || 0)
  end

  # Init tax with 0 if nil and cast to BigDecimal
  # == Return
  # <BigDecimal>
  def conv_tax
    to_bd(tax || 0)
  end

  # Cast a val to BigDecimal
  # == Return
  # <BigDecimal>
  def to_bd(val)
    val.is_a?(BigDecimal) ? val : BigDecimal.new("#{val}")
  end

end