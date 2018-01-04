def initialize_rspec
  puts "Setting RSpec..."
  generate "rspec:install"
  run "rm -rf test"

  copy_static_file "spec/supports/capybara.rb"
  copy_static_file "spec/supports/factory_bot.rb"

  uncomment_lines "spec/rails_helper.rb", /Dir\[Rails\.root\.join/
  insert_into_file "spec/rails_helper.rb", after: /require \'rspec\/rails\'\n/ do
    <<~RUBY
      require "supports/capybara"
      require "supports/factory_bot"
    RUBY
  end

  puts "\n"
end

def initialize_guard
  puts "Initialize guard..."
  run "bundle exec guard init rspec"
  gsub_file "Guardfile",
    /guard :rspec, cmd: "bundle exec rspec" do/,
    'guard :rspec, cmd: "bin/rspec" do'
  puts "\n"
end

initialize_rspec
initialize_guard
