module Validators
  class UserValidator
    WHITE_LIST = %i[username password]

    def call(params)
      return false if params.nil?
      in_white_list?(params)
    end

    private
    def in_white_list?(params)
      params.each do |name|
        return false unless WHITE_LIST.include?(name.to_sym)
      end

      params.permit! # rails params.. meh...

      true
    end
  end
end
