require 'models/task_manager'

class TaskManagerApp < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')

  get '/' do
    erb :dashboard
  end

  get '/tasks' do
    @tasks = TaskManager.all
        # ["task1", "task2", "task3"]
    erb :index
  end

  get '/tasks/new' do
    erb :new
  end

  post '/tasks' do
    # "<p>Params: #{params}</p> <p>Task params: #{params[:task]}</p>"
    TaskManager.create(params[:task])
    redirect '/tasks'
  end

  get '/tasks/:id' do |id|
    @task = TaskManager.find(id.to_i)
    erb :show
  end
end

