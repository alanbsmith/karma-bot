class Api::V1::UsersController < ApplicationController
  respond_to :json

  # GET api/v1/users.json
  def index
    @users = User.all
    render json: @users
  end

  # GET api/v1/users/1
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # POST api/v1/users{id}
  def create
    @user = User.new(user_params)

    if user.save
      respond_with @user
    end
  end

  # PATCH api/v1/users/{id}
  def update
    @user = User.find(params[:name])
    @user.update_attributes(note_params)
    render json: @user
  end

  # DELETE api/v1/users/{id}
  def destroy
    @user = User.find(params[:name])
    @user.destroy
    render status: 200, json: 'ok'
  end

  private

  def user_params
    params.require(:user).permit(:name, :points)
  end
end
