class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update ]
	def correct_user
		@book = current_user.books.find_by(id: params[:id])
		unless @book
			redirect_to books_path
		end
	end

	def show
		@book_show = Book.find(params[:id])
		@book= Book.new
		@author = User.find(@book_show.user_id)

	end

	def index
		@book =Book.new
		@books =Book.all
	end


	def edit
		@book =Book.find(params[:id])

	end

	def update
		book = Book.find(params[:id])
		if book.update(book_params)
		   flash[:notice] = "Book was successfully created."
		   redirect_to book_path(book)
		else
			flash[:notice] = "error"
			render :edit
		end
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if@book.save
			flash[:notice] = "Book was successfully created."
			redirect_to book_path(@book.id)
		else
			flash[:notice] = "error "
			@books =Book.all
			render :index
		end


	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
