# frozen_string_literal: true

require_relative "tempora/version"
require_relative "timeperiod"
require_relative "year"
require_relative "month"
require_relative "week"
require_relative "quarter"


module Tempora
  class Error < StandardError; end
end

Object.send(:include, Tempora)