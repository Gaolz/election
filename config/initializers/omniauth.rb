Rails.application.config.middleware.use OmniAuth::Builder do
    provider :wechat, Yetting.wechat_app_id, Yetting.wechat_app_secret
end