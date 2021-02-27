class BooksController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def correct_user
        @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end
  
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = current_user
  end
  
  def new
    @book = Book.new
  end 

  def create
     @book = Book.new(book_params)
     @user = current_user
     @book.user_id = current_user.id
     if @book.save
      redirect_to  book_path(@book)
      flash[:notice] = 'Book was successfully created.'
     else
      @books = Book.all
      render 'index'
     end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book)
       flash[:update] = 'Book was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
    flash[:destroy] = 'Book was successfully destroyed.'
  end



 private

  def book_params
    params.require(:book).permit(:title, :body)
  end



end
