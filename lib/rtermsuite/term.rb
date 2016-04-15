
module Rtermsuite
  class Term
    include Enumerable
    extend Forwardable
    def_delegators :@ts_term, :frequency, :id, :lemma, :spotting_rule, :pattern,
                  :grouping_key, :general_frequency_norm, :frequency_norm,
                  :occurrences, :variations, :words, :compound?,
                  :document_frequency,
                  :context_vector_computed?, :single_word?, :variant?

    alias_method :dfreq, :document_frequency
    alias_method :freq, :frequency
    alias_method :freq_norm, :frequency_norm
    alias_method :gfreq_norm, :general_frequency_norm
    alias_method :gkey, :grouping_key
    alias_method :occs, :occurrences



    def initialize ts_term_index, ts_term
      @ts_term_index = ts_term_index
      @ts_term = ts_term
    end

    def wr
      @wr = @ts_term_index.getWRMeasure.value(@ts_term)
    end

    def pilot
      @pilot = form_getter.getPilot(@ts_term)
    end

    def form_getter
      @@form_getters ||= {}
      @@form_getters = {} if @@form_getters.size > 1
      @@form_getters[@ts_term_index.name] ||= Java::EuProjectTtcUtils::TermUtils.form_getter(@ts_term_index, true)
    end

    def wr_log
      @wr_log = @ts_term_index.getWRLogMeasure.getValue(@ts_term)
    end



    def each
      for tw in @ts_term.term_words
        yield tw
      end
    end
  end
end
