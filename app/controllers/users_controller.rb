class UsersController < ApplicationController
   
   def index
      @users = User.all
   end

   def new
      @user = User.new
   end 
   
   def show
      @user = User.find(params["id"])
   end

   def create
      @user = User.new(user_params)
      if @user.save
         flash[:success] ="Welcome to Properties #{@user.username}"
         redirect_to properties_path
      else
         render 'new'
      end
   end

   def edit
      @user = User.find(params[:id])
   end
   
   def update
      @user = User.find(params[:id])
      if @user.update(user_params)
         flash[:success] = "The account was successfully update"
         redirect_to properties_path
      else
         render 'edit'
      end
   end

   private
   def user_params
      params.require(:user).permit(:username, :email, :password)
   end
   
end