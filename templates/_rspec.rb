# frozen_string_literal: true

puts "Initialize RSpec..."
generate "rspec:install"
run "rm -rf test"

uncomment_lines "spec/rails_helper.rb", /Dir\[Rails\.root\.join/

copy_static_file "spec/support/capybara.rb"
copy_static_file "spec/support/database_cleaner.rb"
copy_static_file "spec/support/factory_bot.rb"

insert_into_file "spec/rails_helper.rb", after: /require \'rspec\/rails\'\n/ do
  <<~RUBY
    require "support/capybara"
    require "support/database_cleaner"
    require "support/factory_bot"
  RUBY
end

insert_into_file "spec/rails_helper.rb", before: /RSpec\.configure do \|config\|/ do
  <<~RUBY
    config.before :each, type: :system do
      driven_by :selenium_remote_chrome
      host! "http://#{IPSocket.getaddress(Socket.gethostname)}"
    end
  RUBY
end
puts "\n"

insert_into_file "spec/spec_helper.rb", before: /RSpec\.configure do \|config\|/ do
  <<~RUBY
    require "simplecov"

    SimpleCov.start do
      add_filter "/vendor/"
      add_filter "/spec/"
    end

  RUBY
end
puts "\n"

puts "Initialize Guard..."
run "bundle exec guard init rspec"
gsub_file "Guardfile",
          /guard :rspec, cmd: "bundle exec rspec" do/,
          'guard :rspec, cmd: "bin/rspec" do'
puts "\n"
