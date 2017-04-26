module Entities
  class User < OpenStruct
    # attrs :id, :username, :password, :created_at, :updated_at
    # TODO password shouldn't be a string

    def friendly_name
      username
    end
  end
end
