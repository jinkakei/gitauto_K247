require "git_k247"
include Git_K247

#Git_K247::git_add_interactive

  def get_gitdirs 
    current_dir = Dir.pwd
    home = ENV['HOME']
  
    gdfile = "#{home}/git_dir_k247.txt"
    gitdirs = Array.new(1)
    puts "Git Directories"
    open( gdfile, "r").each_with_index{ | line, n |
      gitdirs[n] = line.chomp
      #puts "  #{n}: #{gitdirs[n]}"
    }
    return gitdirs
  end # def get_gitdirs 


def git_gdir_each( arg=nil )
  if arg == "pull" || arg == "push"
    gact = arg
  else
    gact = "pull"
    puts "Set git action pull"
  end

  gitdirs = get_gitdirs
    gret = Array( gitdirs.length )
  gitdirs.each_with_index do | gdir,n |
    ret = Dir::chdir( gdir )
    puts "Current dir: #{Dir::getwd}"
    unless File::exist?(".git")
      puts "!Caution! This directory is not registered on git!"
      gret[n] = -1
    else
      if gact == "pull"
        gret[n] = git_pull_interactive
      else # "push"
        git_commit_interactive
        gret[n] = git_push_interactive
      end # if gact == "pull"
    end
  end
  
  print "\n\n\n"; puts "Results (0: true, -1: false)"
  gitdirs.each_with_index do | gdir,n |
    puts "  #{gdir} (#{gret[n]})"
  end
  print "\n"
  
  return 0
end # def git_gdir_each( arg=nil )


ret = git_gdir_each


