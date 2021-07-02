class FavoritesController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    favorite = current_user.favorites.new(recipe_id: @recipe.id)
    favorite.save
    #redirect_back(fallback_location: root_path)
    #redirect_to File.join(user_path(@recipe.user.id), '?sort_type=favorite')
    redirect_to "#{user_path(@recipe.user.id)}?sort_type=favorite"
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    favorite = current_user.favorites.find_by(recipe_id: @recipe.id)
    favorite.destroy
    #redirect_back(fallback_location: root_path)
    redirect_to "#{user_path(@recipe.user.id)}?sort_type=favorite"
  end
end
