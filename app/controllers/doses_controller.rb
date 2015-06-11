class DosesController < ApplicationController
  before_action :find_cocktail

  def new
    @dose = Dose.new
    @ingredients_collection = Ingredient.all
  end

  def create
    # if you do params here, it captures all params -> if you do dose_params, it only uses the ones that are in the strong params defined below
    # you could also do: pars = dose_params.merge({cocktail_id" params[:cocktail_id]})
    # -> this is how you see that ingredient_id and cocktail_id are coming from different places and params
    pars = dose_params.merge({cocktail_id: params[:cocktail_id]})
    @dose = Dose.new(pars)
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = @cocktail.doses.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@cocktail)
  end

  protected

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
    # use ingredient_id instead of ingredient, because everything that comes through the params in a string
    # if you use ingredient, rails will look for an object but its a string <> if you use ingredient_id, it's smart enough to look for an integer and get it from the string
    # note - you don't need to pass the cocktail_id through the params, because it's not coming from the new form!
    #        it already KNOWS the cocktail id because you ended up in the new form for the dose via selecting a cocktail with an id first -> that's how you get there
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end
end
