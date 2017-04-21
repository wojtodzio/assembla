module Entities
  class Movie < OpenStruct
    # attrs :id, :title, :duration, :director, :rating, :description, :created_at, :updated_at

    def friendly_name
      "#{title} (#{duration}) by #{director}"
    end
  end
end
