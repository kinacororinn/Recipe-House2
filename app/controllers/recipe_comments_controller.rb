class RecipeCommentsController < ApplicationController
  def index
  end

  def show
  end

  def edit
   @recipe_comment = RecipeComment.find(params[:id])
   @recipe = @recipe_comment.recipe
  end

  def update
   @recipe_comment = RecipeComment.find(params[:id])
   @recipe = @recipe_comment.recipe
   if @recipe_comment.update(recipe_comment_params)
      redirect_to recipe_path(@recipe)
   else
      render "edit"
   end
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    comment = RecipeComment.new(recipe_comment_params)
    comment.user_id = current_user.id
    comment.recipe_id = @recipe.id
    comment.save
    redirect_to recipe_path(@recipe)
    @recipe_comments = @recipe.recipe_comments
    @recipe_comment = RecipeComment.new
  end

  def destroy
    @recipe_comment = RecipeComment.find_by(id: params[:id])
    @recipe = @recipe_comment.recipe
    @recipe_comment.destroy
    redirect_to recipe_path(@recipe)
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:recipe_comment)
  end

end
