@templates_path = File.join(File.dirname(__FILE__))
@source_path = File.join(@templates_path, "src")

def copy_static_file(path)
  puts "Installing #{path}..."
  remove_file path
  file path, File.read(File.join(@source_path, path))
  puts "\n"
end

def initialize_application
  puts "Setting default timezone..."
  application "config.active_record.default_timezone = :local"
  application "config.i18n.default_locale = :ja"
  application "config.time_zone = 'Asia/Tokyo'"

  application do
    "config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]"
  end

  puts "Setting default generators..."
  generators = <<-RUBY
  config.generators do |g|
    g.assets false
    g.helper false
    g.test_framekwork :rspec,
      fixture: true,
      view_specs: false,
      helper_specs: false,
      routing_specs: false,
      controller_specs: false,
      request_specs: true
    g.fixture_replacement :factory_bot, dir: "spec/factories"
  end
  RUBY

  application generators
  puts "\n"
end

def initialize_spring
  puts "Initialize spring..."
  run "bin/spring stop"
  run "bundle exec spring binstub --all"
  puts "\n"
end

def cleanup
  puts "Cleaning up..."
  empty_line_pattern = /^\s*\n/
  comment_line_patttern = /^\s*#.*\n/
  gsub_file "Gemfile", comment_line_patttern, ""
  gsub_file "config/routes.rb", comment_line_patttern, ""
  gsub_file "config/routes.rb", empty_line_pattern, ""
  run "bundle exec rufo config/**/*.rb"
  puts "\n"
end

puts "\n\n========================================================="
puts " Rails Application Template Setup:"
puts "=========================================================\n\n"

apply "#{@templates_path}/_gems.rb"

# initialize_application
apply "#{@templates_path}/_rspec.rb"

# initialize_spring

# initialize_hirb
# TODO: initialize_bullet

cleanup

puts "\n\n========================================================="
puts " Setup completed!!"
puts "=========================================================\n\n"
