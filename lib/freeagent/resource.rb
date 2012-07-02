require 'date'
require 'multi_json'

module FreeAgent
  class Resource
    attr_accessor :id

    def initialize(attrs={})
      attrs.each { |key,val| send("#{key}=", val) if respond_to?("#{key}=") }
    end

    def self.find(id)
      response = FreeAgent.client.get(@@end_point[:plural] + '/' + id.to_s)
      self.new(response[@@end_point[:single]])
    end

    def self.all
      response = FreeAgent.client.get(@@end_point[:plural])
      response[@@end_point[:plural]].collect { |r| self.new(r) }
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

    def self.resource(resource, opts = {})
      @@resource = {:single => end_point, :plural => (opts[:plural] || end_point + 's') }
    end

    def self.date_accessor(*args)
      attr_reader(*args)
      date_writer(*args)
    end

    def self.date_writer
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
