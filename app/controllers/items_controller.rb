class ItemsController < ApplicationController
    layout 'wechat'

    def show
        @item = Item.find(params[:id])
        @item.hit_incr
    end

    def create
        if verify_rucaptcha?
            @item ||= Item.find(params[:item_id])
            @user ||= User.find_by(openid: session[:user_id])
            session[:user_id] = @user.openid
            @item.add_score(@user.id) unless @item.is_voted_by_user? @user.id
            render "items/success.js.erb", format: :js
        else
            @item ||= Item.find(params[:item_id])
            @status = false # 验证码错误
            render "items/vote.js.erb", format: :js
        end
    end

    def vote
        if Redis::Value.new('election:door').nil?
             render js: "alert('投票还未开始')"
        else
            @item ||= Item.find(params[:id])
            @user ||= User.find(openid: session[:user_id])
            if Item.all_voted_user.exclude? @user.id # 如果用户第一次投票
                # 转验证码
                render "items/vote.js.erb", format: :js
            else
                @item.add_score(@user.id) unless @item.is_voted_by_user? @user.id # 用户是否投过该自媒体
                render "items/success.js.erb", format: :js
            end
        end
    end

    def check
        openid = request.env['omniauth.auth'].extra.raw_info.openid
        @user = User.find_or_create_by(openid: openid) do |user|
            user.openid = openid
        end

        user_info = $client.user(openid) # 获取用户资料

        if user_info.result[:subscribe] == 0 # 如果没有关注
            redirect_to follow_path
        else # 1, 表示关注
            session[:user_id] = @user.openid
            params = request.env["omniauth.params"]
            @item ||= Item.find(params["item"])
            redirect_to item_path(@item.id)
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

    def follow
    end
end