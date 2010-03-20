# -*- ruby -*- ## use ruby-mode in editors
require 'rubygems'

# cool gems i like to have on hand
cool_gems = %w{ 
   wirble 
   map_by_method 
}
unavail_gems = []
cool_gems.each do |gem|
  begin
    require gem  
  rescue LoadError=>ex
    unavail_gems << gem
  end
end
puts "To install these gems: \n" + unavail_gems.map{|g| "sudo gem install #{g}"}.join("\n") unless unavail_gems.empty?

# Get history ! (not working on the dell 4400 right now :(  )
require 'irb/ext/save-history'
require 'irb/completion'
IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

# These quick modules/patches let you inspect classes in console easier
module MyClassMethodIntrospection
  def methods_excluding_object
    (self.methods - Object.methods).sort
  end
  def methods_excluding_ancestors
    (self.methods - self.superclass.methods).sort
  end
end
module MyModuleMethodIntrospection
  def methods_excluding_object
    (self.instance_methods).sort
  end
  def methods_excluding_ancestors
    (self.instance_methods - (self.included_modules.map(&:instance_methods).reduce(&:+) || []) ).sort
  end
end
module MyObjectMethodIntrospection
  def methods_excluding_object
    (self.methods - Object.methods).sort
  end
  def methods_excluding_ancestors
    (self.methods - self.class.superclass.methods).sort
  end
end
Class.send(:include, MyClassMethodIntrospection)
Module.send(:include, MyModuleMethodIntrospection)
Object.send(:include, MyObjectMethodIntrospection)


####### Fast inline RI ######
# fastri available ? 
FRI_EXEC = 'qri' # 'fri' to query a running server (fastest), 'qri' for no server dependency, ri -T otherwise
fri_test = `#{FRI_EXEC} Enumerable#inject 2> /dev/null`
case $?
when 0   # good
  $GOTFASTRI = true
when 127 # command not found
  puts "Fastri not found\n=>sudo gem install fastri"
  FRI_EXEC = 'ri -T'
when 255 # server not running
  puts "Fastri found, but server not running.\n=>Type fastri Object at a prompt to see how to remedy."
  FRI_EXEC = 'qri'
end

if $GOTFASTRI || true
module Kernel
  def ri(arg)
    puts `#{FRI_EXEC} "#{arg}"`
  end
  private :ri
end

class Object
  def puts_ri_documentation_for(obj, meth)
    case self
    when Module
      candidates = ancestors.map{|klass| "#{klass}::#{meth}"}
      candidates.concat(class << self; ancestors end.map{|k| "#{k}##{meth}"})
    else
      candidates = self.class.ancestors.map{|klass|  "#{klass}##{meth}"}
    end
    candidates.each do |candidate|
      #puts "TRYING #{candidate}"
      desc = `#{FRI_EXEC} '#{candidate}'`
      unless desc.chomp == "nil"
      # uncomment to use ri (and some patience)
      # desc = `ri -T '#{candidate}' 2>/dev/null` if SLOW_INLINE_RI
      # unless desc.empty?
        puts desc
        return true
      end
    end
    false
  end
  private :puts_ri_documentation_for

  def method_missing(meth, *args, &block)
    if md = /ri_(.*)/.match(meth.to_s)
      unless puts_ri_documentation_for(self,md[1])
        "Ri doesn't know about ##{meth}"
      end
    else
      super
    end
  end

  def ri_(meth)
    unless puts_ri_documentation_for(self,meth.to_s)
      "Ri doesn't know about ##{meth}"
    end
  end
end

RICompletionProc = proc{|input|
  bind = IRB.conf[:MAIN_CONTEXT].workspace.binding
  case input
  when /(\s*(.*)\.ri_)(.*)/
    pre = $1
    receiver = $2
    meth = $3 ? /\A#{Regexp.quote($3)}/ : /./ #}
    begin
      candidates = eval("#{receiver}.methods", bind).map do |m|
        case m
        when /[A-Za-z_]/; m
        else # needs escaping
          %{"#{m}"}
        end
      end
      candidates = candidates.grep(meth)
      candidates.map{|s| pre + s }
    rescue Exception
      candidates = []
    end
  when /([A-Z]\w+)#(\w*)/ #}
    klass = $1
    meth = $2 ? /\A#{Regexp.quote($2)}/ : /./
    candidates = eval("#{klass}.instance_methods(false)", bind)
    candidates = candidates.grep(meth)
    candidates.map{|s| "'" + klass + '#' + s + "'"}
  else
    IRB::InputCompletor::CompletionProc.call(input)
  end
}
#Readline.basic_word_break_characters= " \t\n\"\\'`><=;|&{("
Readline.basic_word_break_characters= " \t\n\\><=;|&"
Readline.completion_proc = RICompletionProc
end # if $GOTFASTRI
