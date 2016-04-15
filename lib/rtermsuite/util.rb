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
  end
end
