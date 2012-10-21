
Hirb.disable if defined? Hirb

Pry.config.editor = "sublime"

# Note that the toggle-color command can also be used to toggle color on and off while in a session.
Pry.color = false

Pry.config.print = proc { |output, value| output.puts "=> #{value.to_yaml}" }

Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'l', 'ls'

Pry.config.hooks.add_hook(:after_session, :say_bye) do
  puts "bye-bye"
end


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
