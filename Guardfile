guard 'rspec', :cmd => 'rspec --colour', :all_on_start => false, :all_after_pass => false do
  watch('spec/spec_helper.rb')                       { 'spec' }
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
end

guard :rubocop do
  watch(%r{.+\.gemspec$})
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
