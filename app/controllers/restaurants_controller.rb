class RestaurantsController < ApplicationController
    before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:search, :index, :show]
    before_action :check_user, except: [:search,  :index, :show]

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
    @reviews = Review.where(restaurant_id: @restaurant.id).order("created_at DESC")
    if @reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @reviews.average(:rating).round(2)
    end
  end

  def search
    if params[:search].present?
      @restaurants = Restaurant.search(params[:search])
    else
      @restaurants = Restaurant.all
    end
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
  	 params.require(:restaurant).permit(:name, :address, :phone, :website, :image)
  end
end
