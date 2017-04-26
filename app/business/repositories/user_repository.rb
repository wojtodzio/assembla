module Repositories
  class UserRepository
    def initialize(orm)
      @orm = orm
    end

    def all
      @orm.all
    end

    def find(id)
      record = @orm.where(id: id).first
      return nil, [ "User with id: #{id} not found" ] if record.nil?

      return record, []
    end

    def create(params)
      record = @orm.create(params)
      return record, error_list(record)
    end

    def update(id, params)
      record = @orm.update(id, params)
      return record, error_list(record)
    end

    def destroy(id)
      @orm.destroy(id)
      return record, error_list(record)
    end

    private
    def error_list(record)
      record.errors.to_a
    end
  end
end
