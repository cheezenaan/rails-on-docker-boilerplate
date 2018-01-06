@templates_path = File.join(File.dirname(__FILE__))
@source_path = File.join(@templates_path, "src")

def copy_static_file(path)
  puts "Installing #{path}..."
  remove_file path
  file path, File.read(File.join(@source_path, path))
  puts "\n"
end

def cleanup
  puts "Cleaning up..."
  empty_line_pattern = /^\s*\n/
  comment_line_patttern = /^\s*#.*\n/
  gsub_file "Gemfile", comment_line_patttern, ""
  gsub_file "config/routes.rb", comment_line_patttern, ""
  gsub_file "config/routes.rb", empty_line_pattern, ""
  run "bundle exec rufo app/ spec/"
  puts "\n"
end

puts "\n\n========================================================="
puts " Rails Application Template Setup:"
puts "=========================================================\n\n"

apply "#{@templates_path}/_gems.rb"
apply "#{@templates_path}/_application.rb"
apply "#{@templates_path}/_rspec.rb"
apply "#{@templates_path}/_essentials.rb"


cleanup

puts "\n\n========================================================="
puts " Setup completed!!"
puts "=========================================================\n\n"
