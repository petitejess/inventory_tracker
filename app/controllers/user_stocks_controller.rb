class UserStocksController < ApplicationController
  before_action :set_user_stock, only: %i[ show edit update destroy ]

  # GET /user_stocks or /user_stocks.json
  def index
    # @user_stocks = UserStock.all
    @user_stocks = UserStock.includes(:user).where("user" => current_user)
    
    # @categories = Category.all
    @categories = Category.includes(:user_stocks).where("user_stocks.user_id" => current_user.id)

    sort_filter
  end

  # GET /user_stocks/1 or /user_stocks/1.json
  def show
  end

  # GET /user_stocks/new
  def new
    @user_stock = UserStock.new
    @user_stock.batches.build
  end

  # GET /user_stocks/1/edit
  def edit
  end

  # POST /user_stocks or /user_stocks.json
  def create
    @user_stock = UserStock.new(user_stock_params)
    @user_stock.user_id = current_user.id

    respond_to do |format|
      if @user_stock.save
        format.html { redirect_to @user_stock, notice: "User stock was successfully created." }
        format.json { render :show, status: :created, location: @user_stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_stocks/1 or /user_stocks/1.json
  def update
    respond_to do |format|
      if @user_stock.update(user_stock_params)
        format.html { redirect_to @user_stock, notice: "User stock was successfully updated." }
        format.json { render :show, status: :ok, location: @user_stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_stocks/1 or /user_stocks/1.json
  def destroy
    @user_stock.destroy
    respond_to do |format|
      format.html { redirect_to user_stocks_url, notice: "User stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Sort
    def sort_filter
      # Filter
      # Only check cats that have user_stock(s)
      @categories_filter = []
      @user_stocks.each do |stock|
        @categories_filter << stock.category.name
      end
      @categories_filter.uniq!

      if params[:filter_by] == nil
        filter_by = @categories_filter
      else
         # Avoid using params to interact with db (SQL injection)
         cats = []
        @categories_filter.each do |cat|
          cats << cat if params[:filter_by].include?(cat)
        end
        session[:filter_by] = cats
        filter_by = session[:filter_by]
      end

      @user_stocks = @user_stocks.includes(:category).where("categories.name" => filter_by)

      # Sort
      session[:sort_by] = params[:sort_by]
      case session[:sort_by]
      when "Exp Date (Earliest)"
        @user_stocks = @user_stocks.includes(:batches).order("batches.expiry ASC")
      when "Exp Date (Latest)"
        @user_stocks = @user_stocks.includes(:batches).order("batches.expiry DESC")
      when "Qty (Least)"
        @user_stocks = @user_stocks.includes(:batches).order("batches.quantity ASC")
      when "Qty (Most)"
        @user_stocks = @user_stocks.includes(:batches).order("batches.quantity DESC")
      when "Stock Name (A-Z)"
        @user_stocks = @user_stocks.order("user_stocks.name ASC")
      when "Stock Name (Z-A)"
        @user_stocks = @user_stocks.order("user_stocks.name DESC")
      when "Category Name (A-Z)"
        @user_stocks = @user_stocks.includes(:category).order("categories.name ASC")
      when "Category Name (Z-A)"
        @user_stocks = @user_stocks.includes(:category).order("categories.name DESC")
      end
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_user_stock
      @user_stock = UserStock.includes(:user).where("user" => current_user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_stock_params
      params.require(:user_stock).permit(:name, :image, :category_id, :user_id, batches_attributes: [:expiry, :quantity])
    end
end
