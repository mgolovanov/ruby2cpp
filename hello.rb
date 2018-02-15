#!/usr/bin/env ruby
require 'libhello'

module MemInfo
  # This uses backticks to figure out the pagesize, but only once
  # when loading this module.
  # You might want to move this into some kind of initializer
  # that is loaded when your app starts and not when autoload
  # loads this module.
  KERNEL_PAGE_SIZE = `getconf PAGESIZE`.chomp.to_i rescue 4096 
  STATM_PATH       = "/proc/#{Process.pid}/statm"
  STATM_FOUND      = File.exist?(STATM_PATH)
  def self.rss
    STATM_FOUND ? (File.read(STATM_PATH).split(' ')[1].to_i * KERNEL_PAGE_SIZE) / 1024 : 0
  end
end

def printMem
  #print("<<< Memory: ", MemInfo.rss, "K \n")
  puts 'RAM USAGE: ' + `pmap -x #{Process.pid}` # | tail -1`[10,40].strip
  puts ""
end

# Warm-up
i = 0
while i < 100000
  i += 1
end

puts(">>> simple C API call...")
beginning_time = Time.now
Libhello.sayHello('C++')
end_time = Time.now
puts "<<< Time elapsed #{(end_time - beginning_time)*1000} ms"
printMem

# It looks like C++ runtime gets lazily loaded here?
# Because the first time invocation of StringMap.new
# is more expensive than the second time below.
puts(">>> passing map to C++ API...")
beginning_time = Time.now
m = Libhello::StringMap.new
m['a']='1'
m['b']='2'
Libhello.printMap(m)
end_time = Time.now
puts "<<< Time elapsed #{(end_time - beginning_time)*1000} ms"
printMem

puts(">>> passing hash to C++ API...")
beginning_time = Time.now
m2 = Libhello::StringMap.new
m = { "c" => "3", "d" => "4" }
m.each{ |key, value| m2[key]=value }
Libhello.printMap(m2)
end_time = Time.now
puts "<<< Time elapsed #{(end_time - beginning_time)*1000} ms"
printMem

puts(">>> pretty-print JSON...")
beginning_time = Time.now
Libhello.printJSON('{"example": 1}')
end_time = Time.now
puts "<<< Time elapsed #{(end_time - beginning_time)*1000} ms"
printMem

# Release the hash and map
m = nil
m2 = nil
