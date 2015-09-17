
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


o_str = Array(1)
Open3.popen3("git status") do | stdin, stdout, stderr, wait_thread|
  stdout.each_with_index do |line,n|
    o_str[n] = line
  end
  #p $? #=> #<Process::Status: pid=44292,exited(0)>
end

puts "Check: git status"
puts "o_str line num: #{o_str.length}"
m_kword = "#\tmodified:   "
  o_str.each_with_index do | line, n|
    if line.include?(m_kword)
      m_file = line.split(m_kword)[1].chomp
      puts "file: #{m_file} is modified."
      # show git diff & ask git add or not
    end
  end



