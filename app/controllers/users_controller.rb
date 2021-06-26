class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.limit(10).page(params[:page])
    @favorite_recipes = @recipes.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @sort_type = params[:sort_type] ||= "post"
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
     redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     redirect_to user_path(@user.id),notice: '更新が成功しました'
    else
     render "edit"
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
