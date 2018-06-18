class TasksController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
    @tasks = current_user.tasks.all.order('created_at DESC').page(params[:page])
    end
  end
  
  def show
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskは正常に投稿されました'
      redirect_to @task
    else
      flash[:danger] = 'Taskが投稿されませんでした'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'Taskは正常に更新されました'
      redirect_to @task
    else
      flash[:danger] = 'Taskは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
