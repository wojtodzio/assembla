module Validators
  class MovieValidator
    WHITE_LIST = [ :title, :duration, :director, :rating, :description ]

    def call(params)
      return false if params.nil?
      in_while_list?(params)
    end

    private
    def in_while_list?(params)
      params.each do |name|
        return false unless WHITE_LIST.include?(name.to_sym)
      end

      params.permit! # rails params.. meh...

      true
    end
  end
end
