class CategoriesController < ApplicationController
    layout "wechat"
    
    def index
        @categories = Category.find Category.vote.revrange(0, -1)
    end

    def show
        @category = Category.find(params[:id])
        @items = @category.items.where(media: params[:media])
    end

    def ranks
        @categories = Category.find Category.vote.revrange(0, -1)
    end
end