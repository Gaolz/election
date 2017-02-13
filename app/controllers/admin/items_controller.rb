class Admin::ItemsController < AdminController
    before_action :admin_required

    def new
        @item = Item.new
    end

    def show
      @item = Item.find(params[:id])
    end

    def create
        @item = Item.new(params_item)
        if @item.save
            redirect_to admin_items_path
        else
            flash[:alert] = '作品名不能超过7个字'
            render :new
        end
    end

    def edit
        @item = Item.find(params[:id])
    end

    def update
        @item = Item.find(params[:id])
        if @item.update!(params_item)
            redirect_to admin_items_path
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