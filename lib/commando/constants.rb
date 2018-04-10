module Commando
  module Constants
    BLOCK_ARGS                = %i[result success? errors].freeze
    TRACEABLE_ATTRIBUTES      = %i[success? called? errors].freeze
    NOT_IMPLEMENTED_MESSAGE   = '`#call` method has to be implemented'.freeze
    DEFAULT_ERROR_FORMAT_PATH = 'errors.commands.format'.freeze
  end
end
