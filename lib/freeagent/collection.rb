module FreeAgent
  class Collection < Array
    def initialize(response, resource)
      super(response[resource.endpoint[:plural]].collect { |r| resource.new(r) })
      @resource = resource
      @next_page_url = response['next']
      @prev_page_url = response['prev']
      @first_page_url = response['first']
      @last_page_url = response['last']
    end

    def next_page?
      @next_page_url
    end

    def prev_page?
      @prev_page_url
    end

    def first_page?
      @first_page_url
    end

    def last_page?
      @last_page_url
    end

    def next_page
      fetch_page(@next_page_url)
    end

    def prev_page
      fetch_page(@prev_page_url)
    end

    def first_page
      fetch_page(@first_page_url)
    end

    def last_page
      fetch_page(@last_page_url)
    end

    def fetch_page(url)
      uri = URI.parse(url).request_uri.gsub(/^\/v2/, '')
      Collection.new(FreeAgent.client.get(uri), @resource)
    end
  end
end
