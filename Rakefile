require 'yard'

task :default => [:doc, :test_suite_reminder]

# Generate documentation.
YARD::Rake::YardocTask.new :doc do |t|
  t.options = %w(- license.txt)
end

task :test_suite_reminder do
  puts ''
  puts '-------------------------------'
  puts 'Remember to run the TEST SUITE!'
  puts '-------------------------------'
end
