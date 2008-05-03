require 'config/requirements'
require 'config/hoe' # setup Hoe + all gem configuration
require 'spec/rake/spectask'

Dir['tasks/**/*.rake'].each { |rake| load rake }

  Spec::Rake::SpecTask.new('spec') do |t|
    t.spec_opts << '--format' << 'specdoc' << '--colour'
    t.spec_opts << '--loadby' << 'random'
    t.spec_files = Dir["spec/**/*_spec.rb"]
  end