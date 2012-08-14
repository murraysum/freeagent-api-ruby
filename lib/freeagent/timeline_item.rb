module FreeAgent
  class TimelineItem < Resource

    attr_accessor :description, :nature, :is_personal

    date_accessor :dated_on

    decimal_accessor :amount_due
  end
end