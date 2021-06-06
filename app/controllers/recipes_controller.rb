class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipes = Recipe.all
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render "edit"
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    category = Category.find(1)  # ここの処理はCategoryのcontrollerで作成できるようになったあと
    @recipe.category = category  # recipeのformでカテゴリーを選択できるようにしてフォームから保存できるようにする。
    @recipe.user = current_user
    @recipe.save
    redirect_to recipes_path
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private


  def recipe_params
    params.require(:recipe).permit(:image, :title, :component, :explanation)
  end
end
