require 'bundler'
Bundler::GemHelper.install_tasks

require 'erb'
desc "Create a new resource template"
task :create_resource, :resource do |t, args|
  resource = args[:resource] || nil

  unless resource.nil?
    class_name = resource
    class_name.gsub!(/^[a-z]|\s+[a-z]/) { |a| a.upcase }
    class_name.gsub!(/\s/, '')
   
    erb = ERB.new File.read('template.erb')
    puts erb.result(binding)
  end
end