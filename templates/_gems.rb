puts "Installing gems..."
gem_group :development, :test do
  gem "byebug"
  gem "hirb"
  gem "pry-byebug"
  gem "pry-coolline"
  gem "pry-doc"
  gem "pry-rails"
  gem "pry-stack_explorer"
  gem "rails-flog", require: "flog"
  gem 'spring'
  gem "spring-commands-rspec"
  gem 'spring-watcher-listen'
end

gem_group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "bullet"
  gem "brakeman"
  gem "guard-rspec", require: false
  gem 'listen'
  gem "rubocop", require: false
  gem "rufo"
  gem 'web-console'
end

gem_group :test do
  gem "capybara", require: false
  gem "capybara-screenshot"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "rspec-its"
  gem "simplecov"
  gem "selenium-webdriver", require: false
end

Bundler.with_clean_env do
  run "bundle install -j4 --path vendor/bundle"
end
puts "\n"
