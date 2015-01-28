module FreeAgent
  class Category < Resource
    resource :category
    endpoint[:plural] = :categories

    resource_methods :find

    attr_accessor :url, :description, :nominal_code, :allowable_for_tax, :tax_reporting_name, :auto_sales_tax_rate

    def self.all
      response = FreeAgent.client.get("#{endpoint[:plural]}")
      response.values.flatten.collect { |r| self.new(r) }
    end

    def self.find(id)
      response = FreeAgent.client.get("#{endpoint[:plural]}/#{id}")
      self.new(response.values.first)
    rescue FreeAgent::ApiError => error
      raise error if FreeAgent.debug
      nil
    end
  end
end
