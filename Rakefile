require 'rubygems'

task :spec do
  system "jruby -S spec limelight/spec"
  system "jruby -S spec limelight/prop_spec"
  system "spec fresnel_lib/spec"
  
  # gem 'rspec'
  # require 'spec/rake/spectask'
  # 
  # Spec::Rake::SpecTask.new(:all_specs){|t| t.spec_files = FileList['limelight/spec/**/*.rb', 'fresnel_lib/spec/**/*.rb', 'limelight/prop_spec/**/*.rb']}
  # Rake::Task[:all_specs].invoke
end
