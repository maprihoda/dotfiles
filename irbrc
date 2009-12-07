require 'rubygems'

require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'
require 'fileutils'

require 'hirb'
extend Hirb::Console
Hirb.enable


alias p pp
alias q exit


IRB.conf[:PROMPT_MODE] = :SIMPLE
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


# http://drnicwilliams.com/2006/10/12/my-irbrc-for-consoleirb/
class Object
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end


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


# Adapted from http://gist.github.com/138432
HISTFILE = "~/.irb.hist"
MAXHISTSIZE = 1000

def print_line(line_number, show_line_numbers = true)
  print "[%04d] " % line_number if show_line_numbers
  puts Readline::HISTORY[line_number]
end

if defined? Readline::HISTORY
  histfile = File::expand_path(HISTFILE)
  if File::exists?(histfile)
    lines = IO::readlines(histfile).collect { |line| line.chomp }
    Readline::HISTORY.push(*lines)
  else
    FileUtils.touch histfile
  end

  Kernel::at_exit do
    lines = Readline::HISTORY.to_a.reverse.uniq.reverse
    lines = lines[-MAXHISTSIZE, MAXHISTSIZE] if lines.nitems > MAXHISTSIZE
    File::open(histfile, 'w') do |f|
      lines.each { |line| f.puts line }
    end
  end
end

def history(how_many = 50)
  history_size = Readline::HISTORY.size

  # no lines, get out of here
  puts "No history" and return if history_size == 0

  start_index = 0

  # not enough lines, only show what we have
  if history_size <= how_many
    how_many = history_size - 1
    end_index = how_many
  else
    end_index = history_size - 1 # -1 to adjust for array offset
    start_index = end_index - how_many
  end

  start_index.upto(end_index) { |i| print_line i }
  nil
end

alias :h :history


# Rails specific
if ENV['RAILS_ENV']
  def sql(query)
    ActiveRecord::Base.connection.select_all(query)
  end

  class MyQueryLoggingToggler
    def toggle
      if !@log_set
        @log_set = true
        set_logger_to STDOUT
        "logger on"
      else
        @log_set = false
        set_logger_to nil
        "logger off"
      end
    end

    private

    def set_logger_to(stream)
      ActiveRecord::Base.logger = Logger.new(stream)
      if Rails::VERSION::MAJOR >= 2 and Rails::VERSION::MINOR >= 2
        ActiveRecord::Base.connection_pool.clear_reloadable_connections!
      else
        ActiveRecord::Base.clear_active_connections!
      end
      ActiveRecord::Base.colorize_logging = true
    end
  end

  # toggle the logging of SQL queries
  def lg
    @my_tiny_little_query_logging_toggler ||= MyQueryLoggingToggler.new
    @my_tiny_little_query_logging_toggler.toggle
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

