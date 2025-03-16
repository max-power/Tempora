# frozen_string_literal: true

require "i18n"
require_relative "tempora/version"
require_relative "timeperiod"
require_relative "year"
require_relative "month"
require_relative "week"
require_relative "quarter"
require_relative "tempora/formatter"

module Tempora
  class Error < StandardError; end
  
  def self.load_i18n
    I18n.load_path += Dir[File.expand_path("../../config/locales/*.yml", __FILE__)]
  end
end

Tempora.load_i18n if defined?(I18n)

Object.include Tempora