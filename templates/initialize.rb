# frozen_string_literal: true

@templates_path = File.join(File.dirname(__FILE__))
@source_path = File.join(@templates_path, "src")

def copy_static_file(path)
  remove_file path
  file path, File.read(File.join(@source_path, path))
end

puts "\n\n========================================================="
puts " Rails Application Template Setup:"
puts "=========================================================\n\n"

copy_static_file(".gitignore")
copy_static_file("config/database.yml")

rake "db:create"
rake "db:migrate"

puts "\n\n========================================================="
puts " Setup completed!!"
puts "=========================================================\n\n"
