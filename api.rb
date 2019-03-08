class API
  class << self
    def get(_url)
      # Pretend we requested myapi.com
      # here's the response:
      JSON.generate(
        object: {
          id: "123",
        }
      )
    end
  end
end
