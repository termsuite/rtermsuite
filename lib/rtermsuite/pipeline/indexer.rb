module Rtermsuite
  module Pipeline
    class Indexer

      def initialize term_index
        @term_index = term_index

        @tsp = Java::EuProjectTtcTools::TermSuitePipeline.create(term_index, "file:")
            .empty_collection
            .setResourcePath(Rtermsuite.configuration.resource_path)
            .aeStopWordsFilter()
            .aeSpecificityComputer()
            .aeCompostSplitter()
            .aeSyntacticVariantGatherer()
            .aeGraphicalVariantGatherer()
            .aeExtensionDetector()
      end

      def run
        @tsp.run
      end
    end
  end
end
