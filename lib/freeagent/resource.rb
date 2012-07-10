require 'date'
require 'bigdecimal'
require 'multi_json'

module FreeAgent
  class Resource
    attr_accessor :id

    def initialize(attrs={})
      attrs.each { |key,val| send("#{key}=", val) if respond_to?("#{key}=") }
    end

    def self.create(attrs = {})
      self.new(attrs).save
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

    def self.resource_methods(*args)
      if args.include? :default
        define_all
        define_find
        define_delete
      else
        define_all if args.include? :all
        define_find if args.include? :find
        define_delete if args.include? :delete
      end
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
        response = FreeAgent.client.put((resource + '/' + id.to_s), data)
      else
        response = FreeAgent.client.post(resource, data)
      end
    end

    def self.define_all
      self.define_singleton_method(:all) do
        response = FreeAgent.client.get(endpoint[:plural])
        response[endpoint[:plural]].collect { |r| self.new(r) }
      end
    end

    def self.define_find
      self.define_singleton_method(:find) do |id|
        response = FreeAgent.client.get(endpoint[:plural] + '/' + id.to_s)
        self.new(response[endpoint[:single]])
      end
    end

    def self.define_delete
      define_method(:delete) do
        path = endpoint + '/' + id.to_s
        response = FreeAgent.client.delete(path)
      end
    end

  end
end
