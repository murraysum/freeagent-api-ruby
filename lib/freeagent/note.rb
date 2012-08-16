module FreeAgent
  class Note < Resource
    resource :note

    resource_methods :find, :filter, :update, :delete

    attr_accessor :note, :parent_url, :author

    date_accessor :created_at, :updated_at

    # FIXME Need to change POST to allow query strings to be passed to it
    def self.create(attributes)
      raise FreeAgent::NotImplemented.new("FIXME Need to change POST to allow query strings to be passed to it")
    end

    def self.find_all_by_contact(contact)
      Note.filter(:contact => contact)
    end

    def self.find_all_by_project(project)
      Note.filter(:project => project)
    end
  end
end