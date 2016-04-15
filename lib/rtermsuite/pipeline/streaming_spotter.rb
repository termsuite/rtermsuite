module Rtermsuite
  module Pipeline
    class SpotterStream

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
      end

      def stream &consumer_block
        java_provider = @tsp.stream(JRubyConsumer.new(consumer_block))
        JRubyProvider.new(java_provider)
      end



      private
      class JRubyDocument
        include Java::EuProjectTtcReaders::CollectionDocument

        def initialize args={}
          @h = args
        end

        def getUri
          @h[:uri]
        end

        def getText
          @h[:text]
        end
      end

      class JRubyProvider
        def initialize jprovider
          @jprovider = jprovider
        end
        def send_document opts
          @jprovider.provide JRubyDocument.new(opts)
        end
      end

      class JRubyConsumer
        include Java::EuProjectTtcStream.CasConsumer

        def initialize block
          @consumer_block = block
        end

        def consume ts_cas
          @consumer_block.call ts_cas
        end
      end

      def ts_lang
        Java::EuProjectTtcEnginesDesc::Lang.fromCode(@lang)
      end
    end
  end
end
