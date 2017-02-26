
class Todo
  attr_accessor :content, :is_completed
  attr_reader :id

  # Gets data from 'data.json' file
  @@allTodos = JSON.parse(read_file('data.json'))

  def initialize(todo)
    @id = todo['id'] ? todo['id'] : genId
    @content = todo['content']
    @is_completed = todo.has_key?('is_completed') ? todo['is_completed'] : false
  end

  # Saves this todo to 'data.json'. Checks if id exists and updates it if it does
  # exist
  def save
    todo = { 'content' => @content, 'id' => @id, 'is_completed' => @is_completed }
    found_todo = Todo.findTodo(@id)

    if found_todo.empty?
      @@allTodos.push(todo)
      return Todo.presist_data
    end
    Todo.edit(todo)
    Todo.presist_data
  end

  # Delete a this todo from 'data.json'
  def delete
    newTodos = []

    @@allTodos.each { |item|
      if item['id'] != @id
        newTodos.push(item)
      end
    }

    @@allTodos = newTodos
    Todo.presist_data
  end

  # Finds a todo by id. Returns a hash describing the todo or a empty hash
  # if nothing is found
  def self.findTodo(id)
    foundTodo = {};
    @@allTodos.each do |todo|
      if todo['id'] === id
        foundTodo = todo
      end
    end
    foundTodo
  end

  # Edits the passed in todo, then saves it to 'data.json'
  def self.edit(todo)
    edited_todo = {}
    @@allTodos = @@allTodos.map do |hash|
      if hash['id'] === todo['id']
        hash['content'] = todo['content']
        hash['id'] = todo['id']
        hash['is_completed'] = todo['is_completed']
        edited_todo = hash
      end
      hash
    end
    Todo.presist_data
    edited_todo
  end

  # Prints out all todos to user in a pretty wat.
  def self.display_todos
    if @@allTodos.empty?
      return puts 'No todos yet!'
    end
    @@allTodos.each_with_index do |todo, index|
      checkBox = todo['is_completed'] ? '✔'.green : '☐'.yellow

      puts "\n [#{index.to_s.green}] #{todo['content']} #{checkBox}"
    end
  end

  # Returns the allTodos class variable
  def self.allTodos
    @@allTodos
  end

  # Turns @@allTodos into valid json.
  def self.make_json
    @@allTodos.map { |o| Hash[o.each_pair.to_a] }.to_json
  end

  # Writes json to 'data.json'
  def self.presist_data
    data = Todo.make_json
    open('data.json', 'w') { |f|
      f.puts data
    }
  end

  # Deletes all todos and clears 'data.json'
  def self.delete_all
    open('data.json', 'w') { |f|
      f.puts [].to_json
    }
    @@allTodos = []
  end
end
