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
      redirect_to recipe_path(@recipe),notice: '更新が成功しました'
   else
      render "edit"
   end
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    comment = RecipeComment.new(recipe_comment_params)
    comment.user_id = current_user.id
    comment.recipe_id = @recipe.id
    if comment.save
    redirect_to recipe_path(@recipe),notice: "コメントを作成しました"
    @recipe_comments = @recipe.recipe_comments
    @recipe_comment = RecipeComment.new
    else
    redirect_to recipe_path(@recipe),danger: "登録に失敗しました"
    @recipe_comments = @recipe.recipe_comments
    @recipe_comment = RecipeComment.new
    end
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
