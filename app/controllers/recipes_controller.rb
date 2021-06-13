class RecipesController < ApplicationController
  def index
    # 検索ではないとき　ふつうのとき
    if params[:time].blank? && params[:category_id].blank?
      @favorite_recipes = Recipe.limit(4).includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
      @new_recipes = Recipe.limit(4).reverse_order
      return
    else
      # 検索するとき
 
      if params[:category_id].present? && params[:time].present?
        if params[:time] == "+180"
          @recipes = Recipe.eager_load(:category).where('time >= ?', params[:time]).where(categories: {id: params[:category_id]})
        else
          @recipes = Recipe.eager_load(:category).where('time <= ?', params[:time]).where(categories: {id: params[:category_id]})
        end
      elsif params[:category_id].present? && params[:time].blank?
          @recipes = Recipe.eager_load(:category).where(categories: {id: params[:category_id]})
      elsif  params[:category_id].blank? && params[:time].present?
        if params[:time] == "+180"
          @recipes = Recipe.where('time >= ?', params[:time])
        else
          @recipes = Recipe.where('time <= ?', params[:time])
        end
      else
      end

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
      redirect_to recipes_path
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
