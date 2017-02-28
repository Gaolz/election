class ItemsController < ApplicationController
    layout 'wechat'

    def show
        @item = Item.find(params[:id])
        @item.hit_incr
    end

    def vote
        if Redis::Value.new('election:door').nil?
            flash[:alert] = '投票还未开始'
            redirect_back fallback_location: item_path(params[:id])
        else
            @item ||= Item.find(params[:id])
            @user ||= User.second || User.find(openid: session[:openid])
            if Item.voted_users.include? @user.id # 如果用户不是第一次投票
                @item.add_score(@user.id) unless @item.is_voted_by_user? @user.id # 用户是否投过该自媒体
                redirect_back fallback_location:  item_path(@item)
            else
                # 转验证码
            end
        end
    end

    def wechat_ranks
        @items = Item.find Item.wechat_revrange
    end

    def weibo_ranks
        @items = Item.find Item.weibo_revrange
    end

    def search
        # future 
        # 把 :id, :title, :media 存到 redis. redis 里面没有再从 database 里面取 
        @items = Item.where("title like ?", "%#{params[:search]}%")
        respond_to do |format|
            format.json { render :json => @items }
        end
    end
end