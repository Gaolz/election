class ItemsController < ApplicationController
    layout 'wechat'

    def show
        @item = Item.find(params[:id])
    end

    def vote
        @item ||= Item.find(params[:id])
        @user ||= User.first || User.find(openid: session[:openid])
        @item.add_score(@user) unless @user.is_voted_the_item? @item.id
        redirect_back fallback_location:  item_path(@item)
    end
end