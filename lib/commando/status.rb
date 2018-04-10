module Commando
  module Status
    def called?
      @called ||= false
    end

    def success?
      called? && !failure?
    end

    def failure?
      called? && errors.any?
    end

    protected

    def called!
      @called = true
    end
  end
end
