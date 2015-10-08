
Hirb.disable if defined? Hirb

Pry.config.pager = false

Pry.config.prompt = proc { ">> " }

Pry.config.hooks.add_hook(:after_session, :say_bye) do
  puts "bye-bye"
end
