# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' } do
#   watch('config/application.rb')
#   watch('config/environment.rb')
#   watch(%r{^config/environments/.+\.rb$})
#   watch(%r{^config/initializers/.+\.rb$})
#   watch('Gemfile')
#   watch('Gemfile.lock')
#   watch('spec/spec_helper.rb') { :rspec }
# end

 
guard 'rspec', :cli => "-c -f d", :all_on_start => false, :all_after_pass => false do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/launchers/all_specs.rb')         { "spec" }
 # watch('spec/launchers/all_but_requests.rb')  { ["spec/api", "spec/lib", "spec/routing", "spec/controllers", "spec/models", "spec/views", "spec/presenters", "spec/delayed_jobs", "spec/emails", "spec/helpers"] }
 # watch('spec/launchers/requests.rb')          { "spec/requests" }
end

guard 'jasmine', :all_on_start => false, :all_after_pass => false do
  watch(%r{dummy/spec/javascripts/spec\.(js\.coffee|js|coffee)$})     { "spec/javascripts" }
  watch(%r{^dummy/spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$}) { "spec/javascripts" }
  watch(%r{^dummy/spec/javascripts/.+_spec\.js$}) { "spec/javascripts" }
end


#--drb

# guard 'coffeescript', :input => 'app/assets/javascripts/gmaps4rails', :output => 'public/javascripts/gmaps4rails'
# 
#guard 'coffeescript', :input => 'spec/javascripts/coffee', :output => 'spec/javascripts'

# do
#  watch(/^app\/assets\/javascripts\/gmaps4rails\/(.*).coffee/)
# end