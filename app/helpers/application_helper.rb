module ApplicationHelper
    def notice_message
        flash_messages = []

        flash.each do |key, msg|
            key = :success if key.to_sym == :notice
            key = :danger if key.to_sym == :alert
            text = content_tag(:div, link_to('x', '#', class: 'close', 'data-dismiss' => 'alert') + msg, class: "alert alert-#{key}")
            flash_messages << text if msg
        end

        flash_messages.join("\n").html_safe
    end

    def edit_action?
        params[:action] == 'edit'
    end

    def title(text)
        content_for :title, text
    end

    def is_wechat?
        params[:media] == '1'
    end

    # To be fix
    def current_user
        User.first
    end
end
