
# 2015-09-17: create
require "open3"
# ref: http://qiita.com/tyabe/items/56c9fa81ca89088c5627

# 2015-09-17: try for login & logout script with git
  # $ git --version
  # git version 1.7.12.4
  # $ ruby -v
  # ruby 1.8.7 (2011-12-28 patchlevel 357) [x86_64-linux]
  #   !CAUTION! return value of Open3.popen3 is different in ruby1.8 ( w is not included)
  #     ref: http://docs.ruby-lang.org/ja/search/query:open3/
# ToDo
#   - using IO object@2015-09-17
#   - 
#   - 
#   - 
#   - 

# Define Methods

  # 2015-09-18: create
  # under construction
  def popen3_wrap( cmd )
    o_str = Array(1)
    Open3.popen3( cmd ) do | stdin, stdout, stderr, wait_thread|
      stdout.each_with_index do |line,n|
        o_str[n] = line
      end
    end
    ret = {"key_meaning"=>"i: stdin, o: stdout, e: stderr, w: wait_thread"}
      ret["o"] = o_str
    return ret
  end
  # 2015-09-18: create
  # tmp method
  def get_y_or_n( question=nil )
    print question
    #print "\ngit add #{m_file}? (answer y/n): "
    answer = gets.chomp
    while (answer != "y") && (answer != "n")
      print "  please answer by y or n: "
      answer = gets.chomp
    end
    return answer
  end


# MAIN
  gstat = popen3_wrap( "git status" )

  puts "Check: git status"
  puts "git status (stdout) line num: #{gstat["o"].length}"

=begin
  is_mod_file = "Changes not staged for commit"
  m_kword = "#\tmodified:   "
  gstat["o"].each_with_index do | line, n|
    if line.include?(m_kword)
      m_file = line.split(m_kword)[1].chomp
      puts "file: #{m_file} is modified."
      gdiff = popen3_wrap("git diff #{m_file}")
      gdiff["o"].each do | line |  puts "    #{line}"  end
      answer = get_y_or_n( "\ngit add #{m_file}? (answer y/n): " )
    end
  end
=end
  gstat["o"].each do | line | p line end
  untracked_kword = "Untracked files"


puts "End of program #{$0}"

