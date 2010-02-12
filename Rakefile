# Personal Rakefile for non-project-specific tasks
# Dean R 02/05/2010
#
require 'rake'
require 'pp'

PWD = ENV['PWD']

task :wtf do
  # TODO port over shell style WTF script
  # Sample Output:

  # Test suite : PASS
  # Git status : WORKING DIRECTORY CLEAN
  # Git remote status : NO UNPUSHED COMMITS

  puts "(In #{PWD})"
  gitstatus = %x(git status)

  case gitstatus
    when /working directory clean/
      gitmsg = "WORKING DIRECTORY CLEAN"
    else
      gitmsg = "DIRTY WORKING DIRECTORY"
  end
  puts gitmsg

  case gitstatus
    when /Your branch is ahead/i
      gitmsg = "UNPUSHED COMMITS EXIST"
    else
      gitmsg = "NO UNPUSHED COMMITS"
  end
  puts gitmsg
end
