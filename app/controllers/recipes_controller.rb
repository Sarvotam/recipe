class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]
  
  def index
    @recipes = Recipe.all

    if params[:search_term].present?
      @recipes = @recipes.where('title LIKE ?', "%#{params[:search_term]}%")
    end

    if params[:category].blank?
       @recipes = @recipes.paginate(page: params[:page], per_page: 8).order('created_at DESC')
    else
      @category_id = Category.find_by(name: params[:category]).id
      @recipes =  @recipes.where(:category_id => @category_id).paginate(page: params[:page], per_page: 8).order("created_at DESC")
    end
  end

  def show
  end

  def new
    if user_signed_in?
      @recipe = current_user.recipes.build
      @recipe.ingredients.build
      @categories = Category.all.map{ |c| [c.name, c.id]}
    else
      redirect_to new_user_registration_path
    end
  end

  def edit
    @recipe.ingredients.build
    @categories = Category.all.map{ |c| [c.name, c.id]}
  end

  def create
    @recipe =current_user.recipes.build(recipe_params)
    # associate recipe with category
    @recipe.category_id = params[:category_id]
      if @recipe.save
         redirect_to @recipe
      else
        render :new
      end
  end

  def update
       @recipe.category_id = params[:category_id]
      if @recipe.update(recipe_params)
        redirect_to recipe_path(@recipe)
      else
        render 'edit'
      end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_url
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:title, :description, :image, :category_id,
                                      ingredients_attributes:[:id, :name, :_destroy],
                                      steps_attributes:[:id, :direction, :_destroy])
    end
end
