
module Rtermsuite
  class TermIndex
    include Enumerable

    attr_reader :ts_term_index
    def initialize ts_term_index
      @ts_term_index = ts_term_index
    end

    def each
      for t in @ts_term_index.terms
        yield Term.new(@ts_term_index, t)
      end
    end
  end
end
