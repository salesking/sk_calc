# Helper methods to
# - convert empty or integer values into Rationals
require 'rational'

module SK::Calc::Helper

  private

  # Init price single with 0 if nil and cast to BigDecimal
  # == Return
  # <BigDecimal>
  def conv_price_single
    (price_single || 0).to_r
  end

  # Init tax with 0 if nil and cast to BigDecimal
  # == Return
  # <BigDecimal>
  def conv_tax
    ((self.respond_to?(:tax) && tax) || 0).to_r
  end

end
