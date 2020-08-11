class RestaurantsController < ApplicationController
    before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def new
  	@restaurant = Restaurant.new
  end

  def index
  	@restaurants = Restaurant.all
  end

  def create
  	 @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:success] = "Restaurant was created successfully!"
      redirect_to restaurant_path(@restaurant)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  	if  @restaurant.update(restaurant_params)
      flash[:success] = "Restaurant was updated successfully!"
      redirect_to restaurant_path(@restaurant)
    else
      render 'edit'
    end
  end

  def destroy
    @restaurant.destroy
    flash[:success] = "Restaurant deleted successfully"
    redirect_to restaurants_path
  end


  private

  def set_restaurant
  	@restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
  	params.require(:restaurant).permit!
  end
end
