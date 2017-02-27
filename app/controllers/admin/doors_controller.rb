class Admin::DoorsController < AdminController
    before_action :admin_required

    def show
        @door = Redis::Value.new('election:door').value
    end

    def update
        if params[:door].to_i == 1
            Redis::Value.new('election:door').value = 1
        else
            Redis::Value.new('election:door').value = nil
        end
        redirect_back fallback_location:  admin_door_path
    end
end