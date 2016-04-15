module Rtermsuite
  module Util
    def ts_lang code
      Java::EuProjectTtcEnginesDesc::Lang.fromCode(code)
    end

    def ts_colltype type
      case type
      when :txt, "txt", "TXT" then Java::EuProjectTtcEnginesDesc::TermSuiteCollection::TXT
      when :tei, "tei", "TEI" then Java::EuProjectTtcEnginesDesc::TermSuiteCollection::TEI
      else Java::EuProjectTtcEnginesDesc::TermSuiteCollection::TXT
      end
    end

    def ruby_term_index ts_term_index
      Rtermsuite::TermIndex.new(ts_term_index)
    end
  end
end
