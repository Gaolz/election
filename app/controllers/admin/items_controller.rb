class Admin::ItemsController < AdminController
    before_action :admin_required

    def new
        @category = Category.find(params[:category_id])
        @item = Item.new
    end

    def show
      @item = Item.find(params[:id])
    end

    def create
        @item = Item.new(params_item)
        if @item.save
            redirect_to admin_category_path(params.dig(:item, :category_id)), flash: { notice: '创建成功' }
        else
            render :new
        end
    end

    def edit
        @category = Category.find(params[:category_id])
        @item = Item.find(params[:id])
    end

    def update
        @item = Item.find(params[:id])
        if @item.update(params_item)
            redirect_to admin_category_path(params.dig(:item, :category_id)), flash: { notice: '修改成功' }
        else
            render :edit
        end
    end

    def index
        # @q = Item.ransack(params[:q])
        # @items = @q.result
        @items = Item.includes(:category).order(id: :desc)
    end

    private

        def params_item
            params.require(:item).permit(:title, :info, :media, :category_id, :avatar)
        end
end