module Rtermsuite
  module Pipeline
    class TerminoExtractor

      def initialize lang, *args
        @lang = lang

        @tsp = Java::EuProjectTtcTools::TermSuitePipeline.create(@lang, "file:")
            .setResourcePath(Rtermsuite.configuration.resource_path)
            .aeWordTokenizer()
            .setTreeTaggerHome(Rtermsuite.configuration.treetagger_home)
            .aeTreeTagger()
            .aeUrlFilter()
            .aeStemmer()
            .aeRegexSpotter()
            .aeStopWordsFilter()
            .aeSpecificityComputer()
            .aeCompostSplitter()
            .aeSyntacticVariantGatherer()
            .aeGraphicalVariantGatherer()
            .aeExtensionDetector()
      end

      def run corpus
        @tsp.setCollection(ts_colltype(corpus.collection_type), corpus.path, corpus.encoding)
        @tsp.run
      end

      def term_index
        Rtermsuite::TermIndex.new(@tsp.getTermIndex)
      end

      private

      def ts_colltype type
        case type
        when :txt, "txt", "TXT" then Java::EuProjectTtcEnginesDesc::TermSuiteCollection::TXT
        when :tei, "tei", "TEI" then Java::EuProjectTtcEnginesDesc::TermSuiteCollection::TEI
        else Java::EuProjectTtcEnginesDesc::TermSuiteCollection::TXT
        end
      end

      def ts_lang
        Java::EuProjectTtcEnginesDesc::Lang.fromCode(@lang)
      end
    end
  end
end
