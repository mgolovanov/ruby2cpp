require 'bundler/gem_tasks'
require 'rake/clean'

CLEAN.include('ext/**/*{.o,.log,.so,.bundle}')
CLEAN.include('ext/**/Makefile')
CLOBBER.include('lib/*{.so,.bundle}')

desc 'Build the libhello C++ extension'
task :build_ext do
  Dir.chdir("ext/") do
    sh "swig -c++ -ruby libhello.i"
    ruby "extconf.rb"
    sh "make CPPFLAGS=-std=c++11"
    sh "make install"
  end
  cp "ext/libhello.so", "lib/"
end
