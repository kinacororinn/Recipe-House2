class RecipesController < ApplicationController
  def index
    @favorite_recipes = Recipe.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @recipes = Recipe.limit(6).order(created_at: :desc)

    query = nil
    if params[:time] != nil
      query += "time <= " + params[:time]
    end
    if params[:category] != nil
      if query != nil
        query += " AND "
      end
      query += "category = " + params[:category]
    end
    if query != nil
      @recipes = Recipe.where(query)
    else
      @recipes = Recipe.all
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipes = Recipe.all
    @recipe_comment = RecipeComment.new
    @recipe_comments = @recipe.recipe_comments
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
    #category = Category.find(1)  # ここの処理はCategoryのcontrollerで作成できるようになったあと
    #@recipe.category = category # recipeのformでカテゴリーを選択できるようにしてフォームから保存できるようにする。
    @recipe.user = current_user
    @recipe.save!

    redirect_to recipes_path
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private


  def recipe_params
    params.require(:recipe).permit(:image, :title, :component, :explanation, :category_id,:time)
  end
end
