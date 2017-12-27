source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.0.6'
gem 'sqlite3'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise'
gem "figaro"
gem 'foundation-rails'
gem 'stripe'
gem "nested_form"
gem 'cloudinary'
gem 'attachinary'
gem "jquery-fileupload-rails"
gem "font-awesome-rails"
gem 'geocoder'
gem 'ransack'
gem 'ice_cube'
gem 'simple_calendar'
gem 'recurring_select',  git: 'https://github.com/sahild/recurring_select.git', branch: 'master'
gem 'chart-js-rails'
gem 'groupdate'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
