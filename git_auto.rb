
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
p o_str
Open3.popen3("git status") do | i, o, e, w|
  puts "stdout: "
  #o.each do |line| p line end
  o.each_with_index do |line,n|
    o_str[n] = line
  end
  #puts "stderr: "
  #p e
  #e.each do |line| p line end #=> 
  p $? #=> #<Process::Status: pid=44292,exited(0)>
end

puts "Check: o_str"
mod_kword = "#\tmodified:   "
#mod_kword = "modified"
puts "o_str line num: #{o_str.length}"
o_str.each_with_index do | line, n|
#  puts "#{n}: #{line}"
  #p line if line.include?(mod_kword)
  if line.include?(mod_kword)
    p line.split(mod_kword)[1].chomp
  end
end

=begin
stdout: 
"# On branch master\n"
"#\n"
"# Initial commit\n"
"#\n"
"# Changes to be committed:\n"
"#   (use \"git rm --cached <file>...\" to unstage)\n"
"#\n"
"#\tnew file:   update.txt\n"
"#\n"
"# Untracked files:\n"
"#   (use \"git add <file>...\" to include in what will be committed)\n"
"#\n"
"#\ttest_popen3.rb\n"
stderr: 
#<Process::Status: pid=57525,exited(0)>
)))
=end


=begin
Open3.popen3("sleep 5") do | i, o, e, w|
# donot work
  p i.class #=> IO
  p o.class #=> IO
  p e.class #=> IO
  p w.class #=> NilClass
  p $? #=> display status ( difference between ruby 1.8 and 1.9 ?) 
end

Open3.popen3("pwd") do | i, o, e, w|
  p i.class #=> IO
  p o.class #=> IO
  p e.class #=> IO
  p w.class #=> NilClass
end

Open3.popen3("sort >&2") do | i, o, e, w|
  i.write "foo\nbar\nbaz\n"
  i.close
  #o.each do |line| p line end
  e.each do |line| p line end #=> ""bar\n", "baz\n", "foo\n"
  p w.value if w != nil 
end
Open3.popen3("echo a") do | i, o, e, w|
  i.write "foo\nbar\nbaz\n" # no re action
  i.close
  o.each do |line| p line end
  e.each do |line| p line end
  p w.value if w != nil 
end
Open3.popen3("echo a") do | i, o, e, w|
  p i #=> #<IO:0x7f0c79f939e0>
  p o #=> #<IO:0x7f0c79f93968>
  p e #=> #<IO:0x7f0c79f938a0>
  p w #=> nil
#  o.each do |line| p line end
#  e.each do |line| p line end
#  p w.value #=> error Nil class
end
=end


