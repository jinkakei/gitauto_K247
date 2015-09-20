# 2015-09-18~: create
require "open3"
# ref: http://qiita.com/tyabe/items/56c9fa81ca89088c5627

# ToDo
#   - master IO object@2015-09-17
#   - master git branch

# BGN: copied from git_commit_interactive.rb
  # 2015-09-18: create
  # under construction
  def popen3_wrap( cmd )
    o_str = Array(1)
    e_str = Array(1)
    Open3.popen3( cmd ) do | stdin, stdout, stderr, wait_thread|
      stdout.each_with_index do |line,n|
        o_str[n] = line
      end
      stderr.each_with_index do |line,n|
        e_str[n] = line
      end
    end
    ret = {"key_meaning"=>"i: stdin, o: stdout, e: stderr, w: wait_thread"}
      ret["o"] = o_str
      ret["e"] = e_str
    return ret
  end
  
  # 2015-09-18: create
  # tmp method
  def get_y_or_n( question=nil )
    print question
    answer = gets.chomp
    while (answer != "y") && (answer != "n")
      print "  please answer by y or n: "
      answer = gets.chomp
    end
    return answer
  end
# END: copied from git_commit_interactive.rb


# MAIN
# ToDo
#   - 
#   - 
grshow_orig = "git remote show origin"
gstat = popen3_wrap( grshow_orig )
  ff_kword = "fast-forwardable"
  puts grshow_orig
  puts "STDOUT:"; gstat["o"].each do |line| puts line end
  puts "STDERR:"; gstat["e"].each do |line| puts line end
  onum = gstat["o"].length
  if gstat["o"][onum-1].include?( ff_kword )
    answer = get_y_or_n( "git push? (answer y/n): " )
    if answer == "y"
      ret = popen3_wrap("git push -v origin master:master")
      if ret["e"][0] == 1
        ret["o"].each do |line| puts line end
      else
        puts "git push failed"
        ret["e"].each do |line| puts line end
      end
    else
      puts "  donot git push"; print "\n\n\n"
    end # if answer == "y"
  end

puts "End of program #{$0}"
__END__