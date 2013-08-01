require 'date'
require 'uri'
require 'bigdecimal'
require 'multi_json'

module FreeAgent
  class Resource
    attr_accessor :url
    attr_reader :id

    def initialize(attrs={})
      attrs.each do |key,val|
        send("#{key}=", val) if respond_to?("#{key}=")
        @id = extract_id(val) if key == 'url'
      end

    end

    def extract_id(uri)
      URI(uri).path.split('/').last.to_i
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

    def self.resource_methods(*args)
      if args.include? :default
        define_all
        define_filter
        define_find
        define_create_and_save
        define_update
        define_delete
      else
        define_all if args.include? :all
        define_filter if args.include? :filter
        define_find if args.include? :find
        define_create_and_save if args.include? :create
        define_update if args.include? :update
        define_delete if args.include? :delete
      end
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

    def self.define_all
      self.define_singleton_method(:all) do
        response = FreeAgent.client.get(endpoint[:plural])
        response[endpoint[:plural]].collect { |r| self.new(r) }
      end
    end

    def self.define_filter
      self.define_singleton_method(:filter) do |params|
        response = FreeAgent.client.get("#{endpoint[:plural]}/", params)
        response[endpoint[:plural]].collect{ |r| self.new(r) }
      end
    end

    def self.define_find
      self.define_singleton_method(:find) do |id|
        begin
          response = FreeAgent.client.get("#{endpoint[:plural]}/#{id}")
          self.new(response[endpoint[:single]])
        rescue FreeAgent::ApiError => error
          raise error if FreeAgent.debug
          nil
        end
      end
    end

    def self.define_create_and_save
      self.define_singleton_method(:create) do |attributes|
        data = { endpoint[:single].to_sym => attributes }
        response = FreeAgent.client.post(endpoint[:plural], data)
        self.new(response[endpoint[:single]])
      end

     define_method(:save) do
       data = { self.class.endpoint[:single].to_sym => self.to_hash }
       response = nil
         if persisted?
           response = FreeAgent.client.put("#{self.class.endpoint[:plural]}/#{id}", data)
           response = FreeAgent.client.get("#{self.class.endpoint[:plural]}/#{id}")
         else
           response = FreeAgent.client.post(self.class.endpoint[:plural], data)
         end
         self.class.new(response[self.class.endpoint[:single]])
      end

    end

    def self.define_update
      define_method(:update_attributes) do |attributes|
        data = { self.class.endpoint[:single] => attributes }
        response = FreeAgent.client.put("#{self.class.endpoint[:plural]}/#{id}", data)
      end
    end

    def self.define_delete
      define_method(:delete) do
        response = FreeAgent.client.delete("#{self.class.endpoint[:plural]}/#{id}")
      end
    end
  end
end
