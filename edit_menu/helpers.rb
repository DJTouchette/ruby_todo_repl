
def edit_menu_options
  [
    ['Mark as completed', '-c'],
    ['Mark as un-completed', '-u'],
    ['Edit content', '-e'],
    ['Delete', '-d']
  ]
end

# List all todos. Returns a users chosen todo.
def pick_todo
  if Todo.allTodos.empty?
    system "clear"
    puts 'Please add todos, before you can edit them.'.yellow
    return main_menu
  end

  puts 'What todo?'
  Todo.display_todos
  todo_index = check_for_exit(gets.chomp).to_i
  Todo.new(Todo.allTodos[todo_index]);

end

# Prompts user with options. Returns users chosen tasks.
def get_task(todo)
  system "clear"
  puts "Selected #{todo.content}"
  
  make_options(edit_menu_options)
  puts "\n"
  gets.chomp
end

# Logic for user input
def task_case(task, todo)
  system "clear"
  case task
  when '-c'
    toggle_complete(todo, true)
  when '-u'
    toggle_complete(todo, false)
  when '-d'
    system "clear"
    puts "Deleted Todo: #{todo.content}"
    todo.delete
    edit_menu
  when '-e'
    system "clear"
    puts "Please submit your changes: "
    todo.content = check_for_exit(gets.chomp)
    todo.save

    system "clear"
    puts "Updated todo to #{todo.content}"
    edit_menu

  when '-da'
    system "clear"
    puts "Deleted all todos".red
    Todo.delete_all
    main_menu
  when '-m'
    system "clear"
    main_menu
  when 'q'
    system "clear"
    exit
  end
end
