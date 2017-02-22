class CategoriesController < ApplicationController
    layout "wechat"
    
    def index
        @categories = Category.all
    end

    def show
        @category = Category.find(params[:id])
        @items = @category.items.where(media: params[:media])
    end
end