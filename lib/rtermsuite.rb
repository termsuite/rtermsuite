require "rtermsuite/version"
require_relative "rtermsuite/version"
require_relative "rtermsuite/pipeline"
require_relative "rtermsuite/corpus"
require_relative "rtermsuite/term_index"
require_relative "rtermsuite/term"

module Rtermsuite
  #### CONFIGURATION PATTERN ####
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)

      require self.configuration.termsuite_jar

      if self.configuration.enable_logging
        Java::EuProjectTtcToolsCli::TermSuiteCLIUtils.setGlobalLogLevel(configuration.log_level.to_s)
      else
        Java::EuProjectTtcToolsCli::TermSuiteCLIUtils.disableLogging()
      end
    end
  end


  class Configuration
    attr_accessor :termsuite_jar, :resource_path, :treetagger_home, :enable_logging, :log_level
    def initialize
      @enable_logging = true
      @log_level = :info
    end
  end
  ###############################


end
