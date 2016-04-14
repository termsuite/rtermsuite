module Rtermsuite
  class Corpus
    attr_reader :collection_type, :encoding, :path
    def initialize path, opts = {}
      @path = path
      @encoding = opts[:encoding] || "UTF-8"
      @collection_type = opts[:collection_type] || :txt
    end
  end
end
