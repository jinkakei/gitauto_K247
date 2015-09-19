# 2015-09-18: create
require "open3"
# ref: http://qiita.com/tyabe/items/56c9fa81ca89088c5627

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

gstat = popen3_wrap("git status")
p gstat


puts "End of program #{$0}"
__END__
