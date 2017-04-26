class UsersController < ApplicationController
  def new
    @user = user_manager.new
    @errors = []
  end

  def create
    @user, @errors = user_manager.create(params[:user])

    respond_to do |format|
      if @errors.any?
        format.html { render :new }
        format.json { respond_with_json_errors(@errors) }
      else
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: root_path }
      end
    end
  end

  private

  def redirect_to_index_with_errors(errors)
    respond_to do |format|
      format.html { redirect_to users_url, errors: errors }
      format.json { respond_with_json_errors(errors) }
    end
  end

  def respond_with_json_errors(errors)
    render json: errors, status: :unprocessable_entity
  end

  def user_manager
    @user_manager ||= Managers::UserManager.new
  end
end
