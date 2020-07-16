class BookTablesController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant])
    @book_table = BookTable.new
  end

  def create
    @book_table = current_user.book_tables.new(book_table_params)
    unless @book_table.save
      render "new"
    else
      redirect_to table_booked_path
    end
  end

  def show
    @book_table = current_user.book_tables.last
  end

  private
    def book_table_params
      params.require(:book_table).permit(:restaurant_id, :heads, :date, :time)
    end
end