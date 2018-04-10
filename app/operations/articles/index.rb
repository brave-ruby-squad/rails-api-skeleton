module Articles
  class Index < Commando::Base
    DEFAULT_LEFT_ID  = 0
    DEFAULT_RIGHT_ID = 0
    DEFAULT_PAGE     = 1
    DEFAULT_PER_PAGE = 25

    run_before :delay_task
    run_after  :send_email, :add_errors

    def initialize(user:, **params)
      @user     = user
      @left_id  = params.fetch(:left_id,  DEFAULT_LEFT_ID)
      @right_id = params.fetch(:right_id, DEFAULT_RIGHT_ID)
      @page     = params.fetch(:page,     DEFAULT_PAGE)
      @per_page = params.fetch(:per_page, DEFAULT_PER_PAGE)
    end

    private

    attr_reader :user, :left_id, :right_id, :page, :per_page

    def call
      Article.new(body: 'kekekekekek').tap(&:save)
    end

    def delay_task
      puts '========= Task has been queued! =========='
    end

    def send_email
      puts '========= Email has been sent! =========='
    end

    def add_errors
      errors << { lel: 'Ey dyadya stope!', base: 'Oce ti dyadya daesh!' }
    end

    def facade
      @facade ||= ::Articles::IndexFacade.new(
        user:     user,
        left_id:  left_id,
        right_id: right_id,
        page:     page,
        per_page: per_page
      )
    end
  end
end
