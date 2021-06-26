class RecipesController < ApplicationController
  def index
    # 検索ではないとき　ふつうのとき
    if params[:time].blank? && params[:category_id].blank?
      @favorite_recipes = Recipe.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
      @favorite_recipes = Kaminari.paginate_array(@favorite_recipes).page(1).per(3)
      @new_recipes = Recipe.limit(10).page(params[:page]).reverse_order
      return
    else
      # 検索するとき

      if params[:category_id].present? && params[:time].present?
        if params[:time] == "+180"
          @recipes = Recipe.eager_load(:category).where('time >= ?', params[:time]).where(categories: {id: params[:category_id]}).page(params[:page])
        else
          @recipes = Recipe.eager_load(:category).where('time <= ?', params[:time]).where(categories: {id: params[:category_id]}).page(params[:page])
        end
      elsif params[:category_id].present? && params[:time].blank?
          @recipes = Recipe.eager_load(:category).where(categories: {id: params[:category_id]}).page(params[:page])
      elsif  params[:category_id].blank? && params[:time].present?
        if params[:time] == "+180"
          @recipes = Recipe.where('time >= ?', params[:time]).page(params[:page])
        else
          @recipes = Recipe.where('time <= ?', params[:time]).page(params[:page])
        end
      else
      end

    end


  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipes = Recipe.limit(10).page(params[:page])
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
      redirect_to recipes_path,notice: '更新が成功しました'
    else
      render "edit"
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
    redirect_to recipes_path,notice: "登録に成功しました"
    else
    render :new
    end
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
