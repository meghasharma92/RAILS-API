class V1::ReviewsController < ApplicationController

	before_action :load_book, only: [:index, :show, :create]
	before_action :load_review, only: [:show, :update, :destroy]
	before_action :ensure_params_exists, only: [:create, :update, :destroy]
	before_action :authenticity_with_token!, only: [:create, :destroy]

	def index
		reviews = @book.reviews
		if reviews.any?
			reviews = parse_json reviews
			json_response "Show book reviews", true, reviews, :ok
		else
			json_response "Reviews not found", {}, false, :not_found
		end
	end

	def show
		@review = parse_json @review
		json_response "Show Review successfully", @review, true, :ok  
	end

	def create
		review = Review.new(review_params)
		review.user_id = current_user.id
		review.book_id = @book.id
		if review.save
			review = parse_json review
			json_response "create book reviews", true, review, :ok
		else
			json_response "Review creation error", false, {}, :unprocessable_entity
		end
	end

	def update
		if valid_user @review.user
			if @review.update(review_params)
				@review = parse_json @review
				json_response "Updated review", true, @review, :ok
			else
				json_response "Book Update error", false, {}, :failure
			end
		else
			json_response "Authentication fail", {}, false, :not_authorized
		end
	end

	def destroy
		if valid_user @review.user
			if @review.destroy
				@review = parse_json @review
				json_response "deleted review", true, {}, :ok
			else
				json_response "Book deletion error", false, {}, :failure
			end
		else
			json_response "Authentication fail", {}, false, :not_authorized
		end
	end

	private

	def load_book
		@book = Book.find_by(id: params[:book_id])
		return if @book.present?
		json_response "Book not found", {}, false, :not_found 
	end


	def load_review
		@review = Review.find_by(id: params[:id])
		return if @review.present?
		json_response "Review not found", {}, false, :not_found  
	end

	def ensure_params_exists
		return if params[:review].present?
		json_response "Missing params", {}, false, :bad_request 
	end

	def review_params
		params.require(:review).permit(:content_rating, :title, :recommend_rating, :review_image)
	end
end