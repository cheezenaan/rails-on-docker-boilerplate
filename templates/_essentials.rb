# frozen_string_literal: true

puts "Initialize Bullet..."
config = <<-RUBY

  config.after_initialize do
    Bullet.enable = true
    Bullet.add_footer = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
  end
RUBY

environment config, env: :development
puts "\n"

puts "Initialize BetterErrors..."
environment 'BetterErrors::Middleware.allow_ip! "0.0.0.0/0"', env: :development
puts "\n"

puts "Initialize Spring..."
run "bin/spring stop"
run "bundle exec spring binstub --all"
puts "\n"

puts "Initialize Rubocop..."
copy_static_file ".rubocop.yml"
puts "\n"

puts "Initialize Hirb..."
copy_static_file ".pryrc"
puts "\n"
