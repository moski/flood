module Flood
  # Define the gem version number
  class Version
    MAJOR = 0
    MINOR = 0
    PATCH = 0
    PRE = 1

    class << self
      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end
    end
  end
end
