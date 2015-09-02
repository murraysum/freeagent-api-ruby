module FreeAgent
  class InvoiceItem < Resource
    attr_accessor :description, :item_type

    decimal_accessor :price, :quantity, :sales_tax_rate
  end
end
