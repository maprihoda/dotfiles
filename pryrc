
Hirb.disable if defined? Hirb

Pry.config.pager = false

Pry.config.prompt = proc { ">> " }

Pry.config.hooks.add_hook(:after_session, :say_bye) do
  puts "bye-bye"
end

def log(file='console.out', &block)
  File.open(file, 'w') do |f|
    f << "\n\n" + block.call.inspect
  end
end

def log_json &block
  log('console.out.json', &block)
end
