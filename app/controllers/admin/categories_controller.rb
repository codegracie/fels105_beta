class Admin::CategoriesController < AdminController
  def index
    @categories = Category.order(created_at: :desc)
      .paginate page: params[:page], per_page: 5
  end

  def new
    @category = Category.new
  end

  def destroy
    @categories = Category.find params[:id]
    @categories.destroy
    redirect_to admin_categories_path
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_successful"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = t ".create_invalid"
      render :new
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes category_params
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def show
    @category = Category.find params[:id]
  end

  private
  def category_params
    params.require(:category).permit :name, :description, :picture
  end

end
