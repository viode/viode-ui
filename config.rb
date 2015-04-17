Slim::Engine.set_options format: :html

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# PAGES = %w()
# PAGES.each do |page|
#   proxy page, "#{page}.html"
# end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
helpers do
  def flash_class(type)
    case type
    when 'alert' then 'alert-warning'
    when 'error' then 'alert-danger'
    when 'notice' then 'alert-info'
    when 'success' then 'alert-success'
    else type
    end
  end
end

# Deployment configuration
commit_sha = `git log --pretty="%h" -n1`.strip
commit_message = "update to #{commit_sha}"

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
  deploy.branch = 'gh-pages'
  deploy.commit_message = commit_message
end

# Development configuration
configure :development do
  activate :livereload

  Slim::Engine.set_options pretty: true
end

# Build-specific configuration
configure :build do
  # PAGES.map {|p| ignore p }

  ignore 'fonts/bootstrap/*'
  ignore 'stylesheets/main.css'

  activate :minify_css
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets
end

# Copy README.md file to build dir
# after_build do |builder|
#   src = File.join config[:source], 'README.md'
#   dst = File.join config[:build_dir], 'README.md'
#   builder.source_paths << File.dirname(__FILE__)
#   builder.copy_file src, dst
# end
