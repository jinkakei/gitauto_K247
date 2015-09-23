#!/usr/bin/ruby
require "git_k247"
include Git_K247


ret = git_commit_interactive
ret = git_push_interactive


puts "End of program #{$0}"
__END__
