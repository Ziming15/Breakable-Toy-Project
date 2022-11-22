class Api::V1::FoodsController < ApiController
  before_action :authorize_admin, only: [:create]

  def show
    food = Food.where(name: params[:id])
    reviews = Review.where(food_id: params[:id])
    render json: {
      food: food,
      reviews: reviews
    }

  end

  def create
    food = Food.new(food_params)
    food.user = current_user

    if food.save
      render json: food
    else
      render json: { errors: food.errors.full_messages.to_sentence }
    end
  end

  private
  def food_params
    params.permit(:name, :image_url, :flavor, :restaurant_id, :user_id)
  end
end
