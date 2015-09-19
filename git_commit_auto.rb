#!/usr/bin/ruby
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
    w = 0
    Open3.popen3( cmd ) do | stdin, stdout, stderr, wait_thread|
      stdout.each_with_index do |line,n|
        o_str[n] = line
      end
      w = wait_thread
    end
    ret = {"key_meaning"=>"i: stdin, o: stdout, e: stderr, w: wait_thread"}
      ret["o"] = o_str
    return ret
  end
  # 2015-09-18: create
  # tmp method
  def get_y_or_n( question=nil )
    print question # ex. "\ngit add #{m_file}? (answer y/n): "
    answer = gets.chomp
    while (answer != "y") && (answer != "n")
      print "  please answer by y or n: "
      answer = gets.chomp
    end
    return answer
  end

  # 2015-09-19: create
  #   tmp method
  def get_lnum( fname )
    return popen3_wrap("wc -l #{fname}")["o"][0].split(" ")[0].to_i
  end # def get_linenum( fname )


# MAIN
  gstat = popen3_wrap( "git status -s" )
  puts "Check: git status -s (line num: #{gstat["o"].length})"
  gstat.each do | line | puts line end
  m_kword = " M "
    # cf. "M  " means "added but not commit"
  u_kword = "?? "
  gstat["o"].each do | line |
    if line.include?(m_kword)
      m_file = line.split(m_kword)[1].chomp
      puts "file: #{m_file} is modified."
      gdiff = popen3_wrap("git diff #{m_file}")
      lnum = get_lnum(m_file)
      if lnum < 16
        gdiff["o"].each do | line |  puts "    #{line}"  end
      else
        answer = get_y_or_n( "\nDisplay #{m_file}(#{lnum}line)?: " )
        gdiff["o"].each do | line |  puts "    #{line}"  end if answer == "y"
      end
      answer = get_y_or_n( "\ngit add modified #{m_file}? (answer y/n): " )
      if answer == "y"
        puts "git add #{m_file}"; print "\n\n\n"
        gadd = popen3_wrap("git add #{m_file}")
      else
        puts "#{m_file} was modified but not added"; print "\n\n\n"
      end
    end
    if line.include?(u_kword)
      u_file = line.split(u_kword)[1].chomp
      puts "file: #{u_file} is untracked."
      cret = popen3_wrap("cat #{u_file}")
      cret["o"].each do | line |  puts "    #{line}"  end
      answer = get_y_or_n( "\ngit add untracked #{u_file}? (answer y/n): " )
      if answer == "y"
        puts "git add #{u_file}"; print "\n\n\n"
        gadd = popen3_wrap("git add #{u_file}")
      else
        puts "#{u_file} was untracked but not added"; print "\n\n\n"
      end
    end
  end # gstat[o].each do 




puts "End of program #{$0}"

