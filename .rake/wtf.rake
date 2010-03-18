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

  system "rake test 2>&1 1> /dev/null"
  if $? == 0
    puts "TEST SUITE PASSING"
  else
    puts "TESTS SUITE FAILING !!!"
  end

end

desc "Sets config in your env files: rake config cache_classes=(true|false)"
task :config do
  puts "Setting config.cache_classes to #{ENV['cache_classes']}"
  cmd= "sed -i 's/config.cache_classes = \\w*/config.cache_classes = #{ENV['cache_classes']}/g' config/environments/development.rb"
  # puts cmd
  system cmd
  puts "Done."
end
