#!/usr/bin/ruby
require "git_k247"
include Git_K247


ret = git_gdir_each("pull")


puts "End of program #{$0}"
__END__
