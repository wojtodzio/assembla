class MoviesController < ApplicationController
  def index
    @movies = movie_manager.all
  end

  def search
    @query = params[:search]
    @movies = movie_manager.search(@query)
    render :index
  end

  def show
    @movie, @errors = movie_manager.find(params[:id])

    redirect_to_index_with_errors(@errors) and return if @errors.any?
  end

  def new
    @movie = movie_manager.new
    @errors = []
  end

  def edit
    @movie, @errors = movie_manager.find(params[:id])

    redirect_to_index_with_errors(@errors) and return if @errors.any?
  end

  def create
    @movie, @errors = movie_manager.create(params[:movie])

    respond_to do |format|
      if @errors.any?
        format.html { render :new }
        format.json { respond_with_json_errors(@errors) }
      else
        format.html { redirect_to movie_url(@movie.id), notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: movie_url(@movie.id) }
      end
    end
  end

  def update
    @movie, @errors = movie_manager.update(params[:id], params[:movie])

    respond_to do |format|
      if @errors.any?
        format.html { render :edit }
        format.json { respond_with_json_errors(@errors) }
      else
        format.html { redirect_to movie_url(@movie.id), notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: movie_url(@movie.id) }
      end
    end
  end

  def destroy
    _, errors = movie_manager.destroy(params[:id])

    redirect_to_index_with_errors(errors) and return if errors.any?

    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def redirect_to_index_with_errors(errors)
    respond_to do |format|
      format.html { redirect_to movies_url, errors: errors }
      format.json { respond_with_json_errors(errors) }
    end
  end

  def respond_with_json_errors(errors)
    render json: errors, status: :unprocessable_entity
  end

  def movie_manager
    @movie_manager ||= Managers::MovieManager.new
  end
end
