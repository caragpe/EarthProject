class UsersController < ApplicationController
      before_action :set_user, only: [:show, :edit, :update]
      before_action :require_same_user, only: [:edit, :update, :destroy]
      before_action :require_admin, only: [:destroy]
   
   def index
      if current_user.admin?
         @users = User.paginate(page: params[:page],per_page: 5)
      else
         @users = User.where(id: session[:user_id])
      end
   end

   def new
      @user = User.new
   end 
   
   def show
      #@user = User.find(params["id"])
      @user_properties = @user.properties.paginate(page: params[:page],per_page: 2)
   end

   def create
      @user = User.new(user_params)
      if @user.save
         session[:user_id] = @user.id
         flash[:success] ="Welcome to Properties #{@user.username}"
         redirect_to user_path(@user)
      else
         render 'new'
      end
   end

   def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:danger] = "User and properties created by user have been deleted"
      redirect_to users_path
   end
   
   def edit
      #@user = User.find(params[:id])
   end
   
   def update
      #@user = User.find(params[:id])
      if @user.update(user_params)
         flash[:success] = "The account was successfully update"
         redirect_to properties_path
      else
         render 'edit'
      end
   end

   private def user_params
      params.require(:user).permit(:username, :email, :password)
   end
   
   private def set_user
      @user = User.find(params[:id])
   end
   
   private def require_same_user
      if (logged_in? && (current_user != @user)) && !current_user.admin?
         flash[:danger] ="You can only edit or update your own user"
         redirect_to root_path
      end
   end
   
   private def require_admin
      if logged_in? && !current_user.admin?
         flash[:danger] = "Only admin users can perform that action"
         redirect_to root_path
      end
   end
end