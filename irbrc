require 'irb/completion'
require 'fileutils'

begin
  require 'awesome_print'
  AwesomePrint.irb!

  require 'factory_girl_rails'
  include FactoryGirl::Syntax::Methods
rescue LoadError
end

alias q exit

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:USE_READLINE] = true
IRB.conf[:AUTO_INDENT] = true

class Object
  def lmethods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods - BasicObject.methods - [:yaml_tag_subclasses?]).sort
  end
end

# Adapted from http://gist.github.com/138432
module IrbCommandHistory
  HISTFILE = "~/.irb.hist"
  MAXHISTSIZE = 10000

  def self.print_line(line_number, show_line_numbers = false)
    print "[%04d] " % line_number if show_line_numbers
    puts Readline::HISTORY[line_number]
  end

  def self.history(how_many)
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

  def self.init
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
        lines = lines[-MAXHISTSIZE, MAXHISTSIZE] if lines.count > MAXHISTSIZE
        File::open(histfile, 'w') do |f|
          # Don't write out our inquiries about history into the histfile
          lines.each { |line| f.puts line unless line =~ /^(h|history)(\s\d+)?$/ }
        end
      end
    end
  end
end

def history(how_many = 100)
  IrbCommandHistory.history(how_many)
end

alias :h :history

IrbCommandHistory.init
