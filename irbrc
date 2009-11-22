
# auto-complete and history
require 'irb/completion'
require 'irb/ext/save-history'


#---

require 'pp'

alias p pp
alias q exit


#---

IRB.conf[:PROMPT][:MY_PROMPT] = { # name of prompt mode
  :PROMPT_I => '',             # normal prompt
  :PROMPT_S => '',             # prompt for continuing strings
  :PROMPT_C => '',             # prompt for continuing statement
  :RETURN => "# => %s\n"       # :RETURN => "=> %s\n"
}

#IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:PROMPT_MODE] = :MY_PROMPT
IRB.conf[:USE_READLINE] = true
#IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "~/.irb_history"
IRB.conf[:EVAL_HISTORY] = 200


#---

# >> def m
# >>   put 'm'
# >>   end

# > with the "end"'s not lining up below the correct upper lines (here "def"
# > and "class", respectively.) In all the examples I've seen in the book,
# > everything (including comments) line up correctly.

# It is not really possible to do because irb does not know
# when you are going to end a block. Once you have entered
# the end, the only way to get it to line up right would
# be to use terminal controls through Curses or something
# and it probably is not worth the trouble.

# I would recommend to just try to ignore it or, if you
# want, turn autoindent off and enter the whitespace
# yourself :)


#---

# puts l
def l
  %x{ls}.split("\n")
end

def cd(dir)
  Dir.chdir(dir)
  Dir.pwd
end

def pwd
  Dir.pwd
end


#---

# Normally, you can re-read a file with load "<filename>.rb", which works well,
# but is a lot to type over and over. rl lets you just type rl "<filename>",
# and once you’ve called it once, you can just type rl to reload the same file again

def rl(file_name = nil)
  if file_name.nil?
    if !@recent.nil?
      rl(@recent)
    else
      puts "No recent file to reload"
    end
  else
    file_name += '.rb' unless file_name =~ /\.rb/
    @recent = file_name
    load "#{file_name}"
  end
end


#---

class ExceptionsHierarchy
  def initialize()
    @tree = {}
    Module.constants.each do |c|
      c = eval(c.to_s)
      next unless c.instance_of? Class and c.ancestors.include? Exception
      #c.ancestors.reject { |a| [BasicObject, Object, Kernel, PP::ObjectMixin].include? a }.reverse.inject(@tree) { |memo, e| memo[e.name] ||= {} }
      c.ancestors.reject { |a| [Object, Kernel, PP::ObjectMixin].include? a }.reverse.inject(@tree) { |memo, e| memo[e.name] ||= {} }
    end
  end

  def traverse
    do_traverse(@tree)
  end

  private

  def do_traverse(tree, indent=0)
    tree.keys.sort { |i, j| i <=> j }.each do |n|
      puts ' ' * indent + n
      do_traverse(tree[n], indent+=2)
      indent -= 2
    end
  end
end

def exceptions
  ExceptionsHierarchy.new.traverse
end

if $0 == __FILE__
  exceptions
end


#---

# get class methods
class Object
  def cmethods
    my_super = self.class.superclass
    return my_super ? methods - my_super.instance_methods : methods
  end
end


# get instance methods
class Object
  def imethods
    (methods - Object.instance_methods).sort
  end
end


# User.imethods.grep /sql/


#---

# Quick benchmarking
# Based on rue's irbrc => http://pastie.org/179534

def benchmark(repetitions=100, &block)
  require 'benchmark'

  Benchmark.bmbm do |b|
    b.report { repetitions.times &block }
  end
  nil
end


# Can be used like this for the default 100 executions:

#  benchmark { rand }


# Or like this for more:

#  benchmark(10000) { rand }


#---

def timeit
  cur = Time.now
  result = yield
  print "#{cur = Time.now - cur} seconds"
  puts " (#{(cur / $last_benchmark * 100).to_i - 100}% change)" rescue puts ""
  $last_benchmark = cur
  result
end

# Now I can benchmark any block and get the wall clock running time,
# as well as the percent change (+ or -) from the last run


#---

# Rails specific
if ENV['RAILS_ENV']

  def sql(query)
    ActiveRecord::Base.connection.select_all(query)
  end


  # toggle the logging of SQL queries
  def lg
    if !@log_set
      @log_set = true
      set_logger_to STDOUT
    else
      @log_set = false
      set_logger_to nil
    end
  end

  def set_logger_to(stream)
    ActiveRecord::Base.logger = Logger.new(stream)
    if Rails::VERSION::MAJOR >= 2 and Rails::VERSION::MINOR >= 2
      ActiveRecord::Base.connection_pool.clear_reloadable_connections!
    else
      ActiveRecord::Base.clear_active_connections!
    end
    ActiveRecord::Base.colorize_logging = true
    "logger reset!"
  end


  # Log to STDOUT if in Rails
  #if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  #  require 'logger'
  #  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  #end

end


#---
