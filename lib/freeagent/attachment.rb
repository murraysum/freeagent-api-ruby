module FreeAgent
  class Attachment < Resource
    resource :attachment
    
    attr_reader :content_src, :content_type, :file_name, :file_size

   # creatable(false)
    #updatable(false)
  end
end
