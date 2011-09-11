require "awesome_print"
require 'hirb'

Hirb.enable

Pry.config.print = proc do |output, value|
  Hirb::View.view_or_page_output(value) || Pry::DEFAULT_PRINT.call(output, value)
end

alias q exit

Pry.config.editor = "gedit"
Pry.config.prompt = [ proc { ">> " }, proc { " | " }]


class ExceptionsHierarchy
  def initialize()
    @tree = {}
    Module.constants.each do |c|
      c = eval(c.to_s)
      next unless c.instance_of? Class and c.ancestors.include? Exception

      case RUBY_VERSION.split('.')[1]
      when '9'
        c.ancestors.reject { |a| [BasicObject, Object, Kernel].include? a }.reverse.inject(@tree) { |memo, e| memo[e.name] ||= {} }
      when '8'
        c.ancestors.reject { |a| [Object, Kernel].include? a }.reverse.inject(@tree) { |memo, e| memo[e.name] ||= {} }
      end
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


if ENV.include?('RAILS_ENV') or (defined?(Rails) && !Rails.env.nil?)
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
    @logging_toggler ||= MyQueryLoggingToggler.new
    @logging_toggler.toggle
  end
end
