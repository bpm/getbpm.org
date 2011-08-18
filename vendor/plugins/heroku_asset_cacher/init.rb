require 'actionpack_overrides'
Rails.application.config.middleware.insert_before 'ActionDispatch::Static', HerokuAssetCacher
