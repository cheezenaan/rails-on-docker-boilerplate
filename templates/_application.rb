def initialize_application
  puts "Initialize application setting..."
  config = <<-RUBY

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

    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    config.time_zone = "Asia/Tokyo"
  RUBY

  application config
  puts "\n"
end

initialize_application
