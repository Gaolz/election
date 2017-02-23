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

    def wechat_ranks
        @items = Item.find Item.wechat_vote.revrange(0, -1)
    end

    def weibo_ranks
        @items = Item.find Item.weibo_vote.revrange(0, -1)
    end

    def search
        @items = Item.where("title like ?", "%#{params[:search]}%")
        respond_to do |format|
            format.json { render :json => @items }
        end
    end
end