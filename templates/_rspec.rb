def initialize_rspec
  puts "Setting RSpec..."
  generate "rspec:install"
  run "rm -rf test"

  copy_static_file "spec/support/capybara.rb"
  copy_static_file "spec/support/factory_bot.rb"

  uncomment_lines "spec/rails_helper.rb", /Dir\[Rails\.root\.join/
  insert_into_file "spec/rails_helper.rb", after: /require \'rspec\/rails\'\n/ do
    <<~RUBY
      require "support/capybara"
      require "support/factory_bot"
    RUBY
  end

  insert_into_file "spec/spec_helper.rb", before: /RSpec\.configure do \|config\|/ do
    <<~RUBY
      require "simplecov"

      SimpleCov.start do
        add_filter "/vendor/"
        add_filter "/spec/"
      end

    RUBY
  end

  # TODO: Initialize database_cleaner
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
