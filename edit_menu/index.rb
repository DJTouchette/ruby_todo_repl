require_relative 'helpers'
def edit_menu_back_options
  [
    ['Delete All', '-da'],
    ['Back to Main Menu', '-m'],
    ['Quit', 'q']
  ]
end

# Initialze edit menu
def edit_menu
  make_options(edit_menu_back_options)
  puts "\n"
  puts art_edit_menu

  todo = pick_todo
  task = get_task(todo)
  check_for_exit(task)
  task_case(task, todo)
end
