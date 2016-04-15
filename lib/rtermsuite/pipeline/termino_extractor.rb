module Rtermsuite
  module Pipeline
    class TerminoExtractor
      include Util

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
    end
  end
end
