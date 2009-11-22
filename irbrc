require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'


alias p pp
alias q exit


IRB.conf[:PROMPT][:MY_PROMPT] = {   # name of prompt mode
  :PROMPT_I => '',                  # normal prompt
  :PROMPT_S => '',                  # prompt for continuing strings
  :PROMPT_C => '',                  # prompt for continuing statement
  :RETURN => "# => %s\n"            # :RETURN => "=> %s\n"
}

IRB.conf[:PROMPT_MODE] = :MY_PROMPT
# IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:USE_READLINE] = true
# IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "~/.irb_history"
IRB.conf[:EVAL_HISTORY] = 200


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


# http://dancingpenguinsoflight.com/2009/07/improved-irb-configuration/
def benchmark(repetitions=100, &block)
  require 'benchmark'

  Benchmark.bmbm do |b|
    b.report { repetitions.times &block }
  end
  nil
end

#  benchmark { rand }
#  benchmark(10000) { rand }


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
end


# http://www.ruby-forum.com/topic/81406

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
