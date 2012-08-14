module FreeAgent
  class Attachment < Resource
    resource :attachment

    resource_methods :find, :delete
  
    attr_accessor :content_src, :content_type, :file_name, :file_size
  end
end