require 'rubygems'

task :spec do
  gem 'rspec'
  require 'spec/rake/spectask'

  Spec::Rake::SpecTask.new(:all_specs){|t| t.spec_files = FileList['limelight/spec/**/*.rb', 'fresnel_lib/spec/**/*.rb', 'limelight/prop_spec/**/*.rb']}
  Rake::Task[:all_specs].invoke
end
