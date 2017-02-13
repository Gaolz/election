class Admin::CategoriesController < AdminController
    before_action :admin_required

    def new
        @category = Category.new
    end

    def show
      @category = Category.find(params[:id])
    end

    def create
        @category = Category.new(params_category)
        if @category.save
            redirect_to admin_categories_path, flash: { notice:  "成功创建一个组织" }
        else
            flash[:alert] = 'Oops'
            render :new
        end
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])
        if @category.update!(params_category)
            redirect_to admin_categories_path, flash: { notice: "修改成功" }
        else
            flash[:alert] = 'Oops'
            render :edit
        end
    end

    def index
        # @q = category.ransack(params[:q])
        # @categorys = @q.result
        @categories = Category.order(id: :desc)
    end

    private

        def params_category
            params.require(:category).permit(:name)
        end
end