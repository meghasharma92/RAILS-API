class V1::BooksController < ApplicationController

	before_action :load_book, only: [:show]

	def index
		books = Book.all.includes(:reviews)
		book_serialize = parse_json books
		json_response "Books in the index", true, book_serialize, :ok
	end

	def show
		json_response "Book in the show", true, @book, :ok
	end

	private

	def load_book
		@book = Book.find_by(id: params[:id])
		return if @book.present?
		json_response "Book not found", {}, false, :not_found 

	end
end