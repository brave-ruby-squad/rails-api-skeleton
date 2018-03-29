module V1
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]

    def index
      authorize User

      @users = User.all
    end

    def show
      authorize @user
    end

    def update
      authorize @user

      return render :show,  status: :ok, location: @user if update_user

      render json: @user.errors, status: :unprocessable_entity
    end

    def destroy
      authorize @user

      return render json: nil, head: :ok if destroy_user

      render json: @user.errors, status: :unprocessable_entity
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def update_user
      V1::Users::Update.call(user: @user, attributes: user_params)
    end

    def destroy_user
      V1::Users::Destroy.call(user: @user)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
