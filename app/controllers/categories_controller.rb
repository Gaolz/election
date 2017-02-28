class CategoriesController < ApplicationController
    layout "wechat"
    
    def index
        @categories = Category.find Category.vote.revrange(0, -1)
    end

    def show
        @category = Category.find(params[:id])
        @category.hit_incr
        if params[:media] == '1' # wechat
            @items = @category.items.wechat.sort_by{ |item| Item.wechat_revrange.index item.id.to_s }
        else
            @items = @category.items.weibo.sort_by{ |item| Item.weibo_revrange.index item.id.to_s }
        end
    end

end