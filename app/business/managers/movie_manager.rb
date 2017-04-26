
module Managers
  class MovieManager
    def new
      Entities::Movie.new
    end

    def search(query)
      repository.search(query).map { |record| movie_from(record) }
    end

    def all
      repository.all.map { |record| movie_from(record) }
    end

    def find(params)
      record, errors = repository.find(params)
      return movie_from(record), errors
    end

    def create(params)
      apply(params) { repository.create(params) }
    end

    def update(id, params)
      apply(params) { repository.update(id, params) }
    end

    def destroy(id)
      record, errors = repository.destroy(id)
      return movie_from(record), errors
    end

    private
    def apply(params, &block)
      params_valid = validator.call(params)

      return nil, [ 'Invalid request parameters provided' ] unless params_valid

      record, errors = block.call

      return movie_from(record), errors
    end

    def repository
      @repository ||= Repositories::MovieRepository.new(Movie)
    end

    def validator
      @validator ||= Validators::MovieValidator.new
    end

    def movie_from(record)
      params = record.attributes

      Entities::Movie.new(params)
    end
  end
end
