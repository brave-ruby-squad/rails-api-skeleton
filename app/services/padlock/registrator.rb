module Padlock
  class Registrator < ::Callable
    def initialize(params)
      @email                 = params[:email]
      @password              = params[:password]
      @password_confirmation = params[:password_confirmation]
    end

    def call
      User.create(
        email:                 email,
        password:              password,
        password_confirmation: password_confirmation
      )
    end

    private

    attr_reader :email, :password, :password_confirmation
  end
end
