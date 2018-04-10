module Articles
  class Create < Commando::Base
    def initialize(**params)
      @params = params
    end

    def call
      Article.create(params)
    end

    private

    attr_reader :params
  end
end
