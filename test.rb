require 'digest/sha1'

body = 'test'
created_at = Time.now
entries_id = Digest::SHA1.hexdigest("#{created_at}#{body}");

puts entries_id
