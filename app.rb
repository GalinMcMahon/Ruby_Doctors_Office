require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
# require("./lib/list")
require('pg')

DB = PG.connect({:dbname => 'to_do_test'})

get("/") do
  @tasks = Task.all()
  erb(:index)
end

post("/tasks") do
  description = params.fetch("description") #tasks table
  # list_id = params.fetch("list_id").to_i() #tasks table
  # @list = List.find(list_id)
  # @task = Task.new({:description => description, :list_id => list_id})
  # @task.save()
  # task = Task.new(description)
  # task.save()
  erb(:output)
end
