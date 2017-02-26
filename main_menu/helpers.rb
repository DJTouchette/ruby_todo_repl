require 'date'

def main_menu_options
  [
    ['View', 'v'],
    ['Add', 'a'],
    ['Edit', 'e'],
    ['Quit', 'q'],
    ['About', '-about']
  ]
end

# Returns menu options
def menu
  puts art_main_menu

  puts "Todo's for #{Date.today.strftime('%a %d %b %Y')}"
  make_options(main_menu_options)
  puts "\n"

  task = gets.chomp;
end

# Logic for user input
def actions(task)
  case task
  when 'q'
    exit
  when 'v'
    system "clear"
    puts art_view
    Todo.display_todos
    puts "\n [Press any key to return to the Main Menu]"
    gets.chomp
    system "clear"
    main_menu
  when 'a'
    system "clear"
    puts 'Todo: '
    input = check_for_exit(gets.chomp)
    todo = Todo.new({ 'content' => input })
    system "clear"

    puts "Todo added #{todo.content}"
    todo.save
    main_menu
  when 'e'
    system "clear"
    edit_menu

  when '-about'
    system "clear"
    puts about_info
    puts "\n"
    puts '[Press any key to go back to the Main Menu]'
    gets.chomp
    main_menu
  else
    system "clear"
    puts "#{task} not found, back to Main Menu".red
    main_menu
  end
end
