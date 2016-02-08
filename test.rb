require 'json'
require 'yaml'

hash={}
hash['aa'] = 'aaa'
hash['bb'] = 'bbb'

puts hash.to_s
puts hash.to_a


puts true if true
puts true if -1
puts true if 0
