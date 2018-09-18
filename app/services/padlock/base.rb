module Padlock
  class Base < ::Callable
    AUTH_TOKEN_LENGTH        = 19
    VERIFICATION_TOKEN_RANGE = 2..7
  end
end
