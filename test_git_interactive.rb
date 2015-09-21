#!/usr/bin/ruby
# 2015-09-20: create

def exec_command( cmd )
  puts cmd
  ret = system(cmd)
  puts "[end]#{cmd}: #{ret}"
end


exec_command( "git add --interactive" )
  print "\n\n"
exec_command( "git commit --interactive" )
  print "\n\n"


puts "End of program #{$0}"
