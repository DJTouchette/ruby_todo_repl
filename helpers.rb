# Adds menu method to Strings for easily add menu options
class String
  def menu(command)
    "\n #{self}[#{command.green}]"
  end
end

def make_options(options)
  options.each do |option|
    puts option[0].menu(option[1])
  end
end

# Generates a random string
def genId
  (0...50).map { ('a'..'z').to_a[rand(26)] }.join
end

# Reads 'data.json'
def read_file(file_name)
  file = File.open(file_name, "r")
  data = file.read
  file.close
  return data
end

# Checks if user wants to exit or return to menu
def check_for_exit(input)
  if input == '-m'
    return main_menu
  end
  if input == 'q'
    return exit
  end
  if input == '-da'
    system "clear"
    puts "Deleted all todos"
    Todo.delete_all
    return main_menu
  end
  return input
end

# Toggles a todo's is_completed
def toggle_complete(todo, completed)
  todo.is_completed = completed;
  todo.save

  system "clear"
  puts "#{todo.content} was set to #{todo.is_completed}"
  edit_menu
end
