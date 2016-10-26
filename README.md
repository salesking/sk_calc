# SalesKing Calculation
[![Build Status](https://travis-ci.org/salesking/sk_calc.svg?branch=master)](https://travis-ci.org/salesking/sk_calc)

Why?

1. We have had enough of "How do you calculate?"-Questions
2. Ever stumbled upon rounding problems, when calculating totals?
3. Wouldn't it be nice to change a calculation strategy?

We decided to open-source this part, so everybody can transparently see
how we calculate item and document totals.

You can take advantage of this lib for example when using our API and
mixing it into your local classes.


== Install

Ruby 2.2 tested, 1.9 should work to

  gem install sk_calc


== Usage

read spec/sk_calc/*.rb to see examples

  require 'sk_calc'
  class LineItem
    calculates :item
  end
  
  class Invoice
    calculates :items
   end

== Tests

Copyright (c) 2011-2016 Georg Leciejewski, released under the MIT license
