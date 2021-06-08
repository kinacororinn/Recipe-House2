class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
    @favorite_recipes = @recipes.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
     redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
