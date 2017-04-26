module Managers
  class UserManager
    def new
      Entities::User.new
    end

    def all
      repository.all.map { |record| user_from(record) }
    end

    def find(id)
      record, errors = repository.find(id)
      return user_from(record), errors
    end

    def create(params)
      apply(params) { repository.create(params) }
    end

    def update(id, params)
      apply(params) { repository.update(id, params) }
    end

    def destroy(id)
      record, errors = repository.destroy(id)
      return user_from(record), errors
    end

    private
    def apply(params, &block)
      params_valid = validator.call(params)

      return nil, [ 'Invalid request parameters provided' ] unless params_valid

      record, errors = block.call

      return user_from(record), errors
    end

    def repository
      @repository ||= Repositories::UserRepository.new(User)
    end

    def validator
      @validator ||= Validators::UserValidator.new
    end

    def user_from(record)
      params = record.attributes

      Entities::User.new(params)
    end
  end
end
