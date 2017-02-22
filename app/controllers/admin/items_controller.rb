class Admin::ItemsController < AdminController
    before_action :admin_required
    before_action :set_category_and_media, only: [:new, :edit]

    def new
        @item = Item.new
    end

    def show
      @item = Item.find(params[:id])
    end

    def create
        @item = Item.new(params_item)
        if @item.save!
            redirect_to admin_category_path(params.dig(:item, :category_id)), flash: { notice: '创建成功' }
        else
            render :new
        end
    end

    def edit
        @item = Item.find(params[:id])
    end

    def update
        @item = Item.find(params[:id])
        if @item.update!(params_item)
            redirect_to admin_category_path(params.dig(:item, :category_id)), flash: { notice: '修改成功' }
        else
            render :edit
        end
    end

    private

        def params_item
            params.require(:item).permit(:title, :info, :media, :category_id, :avatar)
        end

        def set_category_and_media
            @category = Category.find(params[:category_id])
            @media = params[:media]
        end
end