# we have to provide the full path because the
# rspec plugin hasn't loaded yet
require 'vendor/plugins/rspec/lib/spec/rake/spectask'
require 'vendor/plugins/rspec/lib/spec/rake/verify_rcov'

def report_spec_options
  options_file = File.join(Rails.root, 'spec/spec.opts')
  File.readlines(options_file).map {|e|e.chomp}
end

def report_rcov_options
  options_file = File.join(Rails.root, 'spec/rcov.opts')
  options = File.readlines(options_file).map {|e|e.chomp}
  options
end

def report_files
  files = Dir['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:_report) do |t|
  # these blasted specs are so picky, they simply must be run last
  FileUtils.touch('spec/controllers/theme_support_spec.rb')
  FileUtils.touch('spec/controllers/routing_spec.rb')
  
  t.rcov       = true
  t.spec_opts  = report_spec_options
  t.rcov_opts  = report_rcov_options
  t.spec_files = report_files
end

RCov::VerifyTask.new(:_rcov => :_report) do |t|
  t.threshold = 100.0
  t.index_html = './coverage/index.html'
end

desc "Run all specs with RCov, verify coverage, and display report"
task :report => [:_rcov, :stats]