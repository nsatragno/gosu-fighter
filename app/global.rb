# Global state that should only be built once.
require 'singleton'

class Global
  include Singleton

  attr_accessor :window
end
