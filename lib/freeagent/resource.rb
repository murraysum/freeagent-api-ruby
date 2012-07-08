require 'date'
require 'bigdecimal'
require 'multi_json'

module FreeAgent
  class Resource
    attr_accessor :id

    def initialize(attrs={})

      attrs.each { |key,val| send("#{key}=", val) if respond_to?("#{key}=") }
    end

    def self.find(id)
      response = FreeAgent.client.get(endpoint[:plural] + '/' + id.to_s)
      self.new(response[endpoint[:single]])
    end

    def self.all
      response = FreeAgent.client.get(endpoint[:plural])
      response[endpoint[:plural]].collect { |r| self.new(r) }
    end

    def self.create(attrs = {})
      self.new(attrs).save
    end

    def delete
      path = endpoint + '/' + id.to_s
      response = FreeAgent.client.delete(path)
      # TODO
    end

    def save
      # TODO Finish
      save_date to_hash
    end

    def persisted?
      !id.nil?
    end

    def inspect
      vars = to_hash.collect { |k,v| "#{k}=#{v.inspect}" }
     "#<#{self.class}: #{vars.join(', ')}>"
    end
    
    def to_hash
      hash = {}
      instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
      hash
    end
    
    def to_json
      MultiJson.encode(to_hash)
    end
    
    class << self
      attr_accessor :endpoint
    end

    def self.resource(resource, opts = {})
      self.endpoint = {:single => resource.to_s, :plural => (opts[:plural] || resource.to_s + 's') }
    end

    def self.decimal_accessor(*args)
      decimal_reader(*args)
      decimal_writer(*args)
    end

    def self.decimal_reader(*args)
      attr_reader(*args)
    end

    def self.decimal_writer(*args)
      args.each do |attr|
        define_method("#{attr.to_s}=".to_sym) do |decimal|
          decimal = decimal.is_a?(BigDecimal) ? decimal : BigDecimal.new(decimal)
          instance_variable_set("@#{attr}", decimal)
        end
      end
    end
    def self.integer_accessor(*args)
      integer_reader(*args)
      integer_writer(*args)
    end

    def self.integer_reader(*args)
      attr_reader(*args)
    end

    def self.integer_writer(*args)
      args.each do |attr|
        define_method("#{attr.to_s}=".to_sym) do |int|
          int = int.is_a?(Fixnum) ? int : int.to_i
          instance_variable_set("@#{attr}", int)
        end
      end
    end

    def self.date_accessor(*args)
      date_reader(*args)
      date_writer(*args)
    end

    def self.date_reader(*args)
      attr_reader(*args)
    end

    def self.date_writer(*args)
      args.each do |attr|
        define_method("#{attr.to_s}=".to_sym) do |date|
          date = date.is_a?(String) ? DateTime.parse(date) : date
          instance_variable_set("@#{attr}", date)
        end
      end
    end

    private

    def save_data(data)
      if persisted?
        response = client.put((resource + '/' + id.to_s), data)
      else
        response = client.post(resource, data)
      end
    end
  end
end
