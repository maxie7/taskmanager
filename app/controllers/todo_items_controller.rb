class TodoItemsController < ApplicationController
  before_action :require_user
  before_action :find_todo_list
  
  def index

  end

  def new
  	@todo_item = @todo_list.todo_items.new
  end

  def create
  	@todo_item = @todo_list.todo_items.new(todo_item_params)
  	if @todo_item.save
  	  flash[:success] = "Added project task." 
  	  redirect_to @todo_list
  	else
  	  flash[:error] = "There was a problem adding that project task."
  	  render action: :new
  	end
  end

  def edit
    @todo_item = @todo_list.todo_items.find(params[:id])
   
  end

  def update
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.update_attributes(todo_item_params)
      flash[:success] = "The Task Saved"
      redirect_to @todo_list
    else
      flash[:error] = "That task could not be saved"
      render action: :edit
    end
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
      flash[:success] = "The task was deleted"
    else
      flash[:error] = "The task could not be deleted"
    end
    redirect_to @todo_list
  end

  def complete
    @todo_item = @todo_list.todo_items.find(params[:id])
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: "The task completed"
  end

  def url_options
    { todo_list_id: params[:todo_list_id] }.merge(super)
  end

  private

  def find_todo_list
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  end

  def todo_item_params
    params[:todo_item].permit(:content, :deadline)
  end
end
