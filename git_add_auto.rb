#!/usr/bin/ruby
# 2015-09-17~: create
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
    print question
    answer = gets.chomp
    while (answer != "y") && (answer != "n")
      print "  please answer by y or n: "
      answer = gets.chomp
    end
    return answer
  end


  # 2015-09-19: create
  #
  def get_fname_and_gstate( line )
    gstate_short = line[0..2]
    state_long = conv_gstate(gstate_short)
    fname = line.split(gstate_short)[1].chomp
    if gstate_short == "RM "
      fname = fname.split(" -> ")[1]
    end

    return fname, state_long
  end

    def conv_gstate(gshort)
      if gshort == "?? "
        return "untracked"
      else # " M ", "MM ", "RM "
        return "modified"
      end
    end


  # 2015-09-19: create
  def display_contents( fname, gstate)
    puts "  #{fname} is #{gstate}"
    lnum = get_lnum(fname); ln_limit = 16
    if gstate == "modified"
      fcont = popen3_wrap("git diff #{fname}")["o"]
    else # "untracked"
      fcont = popen3_wrap("cat #{fname}")["o"]
    end
    if lnum < ln_limit
      fcont.each do | line |  puts line  end
    else
      answer = get_y_or_n( "    Display #{fname}(#{lnum}line)?: " )
      if answer == "y"
        fcont.each do | line |  puts line end
      else
        puts "    Do not display #{fname}"
      end
    end
  end # def display_contents( fname, gstate)

    # 2015-09-19: create
    #   tmp method
    def get_lnum( fname )
      return popen3_wrap("wc -l #{fname}")["o"][0].split(" ")[0].to_i
    end # def get_linenum( fname )




# MAIN
# 2015-09-17~: create
# git add automatic
# ToDo
#   - merge "Modified", "Untracked"
#   - use "Renamed"
#   - 
  gstat = popen3_wrap( "git status -s" )["o"]
  puts "Check: git status -s (line num: #{gstat.length})"
  gs_kwords = [" M ", "MM ", "RM ", "?? "]
  if gstat[0] == 1
    puts "nothing to commit"
  else
    puts "files to commit"
    gstat.each do | line |
      if gs_kwords.include?(line[0..2])
        fname, gst = get_fname_and_gstate( line )
        display_contents( fname, gst )
        answer = get_y_or_n( "\n  git add #{gst} #{fname}? (answer y/n): " )
        if answer == "y"
          puts "  #{fname} is git added"; print "\n\n\n"
          ret = popen3_wrap("git add #{fname}")
        else
          puts "  #{fname} is #{gst} but not added"
          print "\n\n\n"
        end
      end
    end # gstat.each do
    gstat2 = popen3_wrap( "git status -s" )["o"]
    puts "Updated git status -s"
    gstat2.each do | line | puts line end
      answer = get_y_or_n( "\ngit commit? (answer y/n): " )
      if answer == "y"
        print "  input message:"; msg = gets.chomp
        msg = msg + " (" + Time.now.to_s + ")"
        p msg
        ret = popen3_wrap("git commit -m #{msg}")
      else
        puts "  #{fname} is #{gst} but not added"
        print "\n\n\n"
      end
  end # if gstat[0] == 1


puts "End of program #{$0}"

