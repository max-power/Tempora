module Tempora
  class TimePeriodFormatter
    I18nScopeKeys = %i(same_day same_month same_year different_year).freeze
    I18nScopeKeysIdentifiers = { begin: :from, end: :till}
    
    # format: [:default, :short, :long] -> see I18n.localize
    def initialize(timeperiod, format: :long) 
      @timeperiod = timeperiod
      @format = format
    end
    
    def render
      from = I18n.l @timeperiod.begin, format: format_for(:from)
      till = I18n.l @timeperiod.end,   format: format_for(:till)
      [from, till].reject(&:empty?).join '–'
    end
    
    private
    
    def format_for(key)
      I18n.t key, scope: [:timeperiod, scope_key, @format]
    end

    def scope_key
      I18nScopeKeyFinder.call(@timeperiod)
    end

    class I18nScopeKeyFinder
      def initialize(timeperiod)
        @timeperiod = timeperiod
      end
      
      def call
        I18nScopeKeys.find { |scope_key| send(:"#{scope_key}?") }
      end
      
      def self.call(timeperiod)
        new(timeperiod).call
      end
      
      private
    
      def different_year?
        !same_year?
      end
  
      def same_year?
        same? :year
      end
  
      def same_month?
        same? :year, :month
      end
  
      def same_day?
        same? :year, :month, :day
      end
    
      def same?(*methods)
        methods.all? { |m| @timeperiod.begin.send(m) == @timeperiod.end.send(m) }
      end
    end
  end
end
