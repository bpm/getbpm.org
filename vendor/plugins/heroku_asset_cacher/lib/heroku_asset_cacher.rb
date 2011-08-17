class HerokuAssetCacher
  def initialize_asset_packager
    $asset_cache_base_path = heroku_file_location  
  end
  
  def initialize(app)
    @app = app
    initialize_asset_packager if ActionController::Base.perform_caching
  end
  
  def call(env)
		@env = env
		if ActionController::Base.perform_caching
      case env['PATH_INFO']
        when /\/stylesheets\/all.css/i then return render_css
        when /\/javascripts\/all.js/i  then return render_js
      end
		end
    
		@app.call(env)
  end
  
  def render_js
		file = "#{heroku_file_location}/all.js"
			[
				200,
				{
				'Cache-Control'  => 'public, max-age=86400',
				'Content-Length' => File.size(file).to_s,
				'Content-Type'   => 'text/javascript'
				},
				File.open(file)
			]
  end
  
  def render_css
		file = "#{heroku_file_location}/all.css"
			[
				200,
				{
				'Cache-Control'  => 'public, max-age=86400',
				'Content-Length' => File.size(file).to_s,
				'Content-Type'   => 'text/css'
				},
				File.open(file)
			]
  end
  
	def heroku_file_location
		"#{RAILS_ROOT}/tmp/asset_cache"
	end
	
end
