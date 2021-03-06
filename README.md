# Rtermsuite

Rtermsuite is a JRuby wrapper for [TermSuite](http://termsuite.github.io/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rtermsuite', git: "https://github.com/termsuite/rtermsuite.git"
```

And then execute:

    $ bundle


## Prerequesites

Before you can run rTermSuite, you need:

 * an installed POS/Tagger
 * TermSuite 2.1's binaries
 * TermSuite's resources
 * a valid TermSuite corpus

All these steps are detailed in TermSuite [documentation](http://termsuite.github.io/documentation/introduction/),
but following the [getting started guide](http://termsuite.github.io/getting-started/) should do it.

## Usage

The following loads rtermsuite and runs a terminology extraction pipeline:

```ruby
require "rtermsuite"

# Configures TermSuite
Rtermsuite.configure do |config|
  config.termsuite_jar= "/path/to/termsuite-core-2.1.jar"
  config.resource_path= "/path/to/termsuite-resources.jar"
  config.treetagger_home= "/path/to/TreeTagger"
end

pip = Rtermsuite::Pipeline::TerminoExtractor.new "fr"
corpus = Rtermsuite::Corpus.new "/path/to/corpus/"
pip.run corpus
termino = pip.term_index

# Shows the 10 first terms by specificity
termino.sort_by(&:wr_log)[-10..-1].reverse.each do |term|
  puts "Term: #{term.pilot}\tSpec: #{"%.2f" % term.wr_log}"
end
```

## Streaming API

TermSuite 2.1 also ships with a beta-streaming API for spotted annotations.
In Rtermsuite, this streaming API is wrapped as follows:

``` ruby
p = Rtermsuite::Pipeline::SpotterStream.new "fr"

stream = p.stream do |ts_cas|
  sdi = ts_cas.source_document_information
  puts "Document processed: #{sdi.uri}"
  puts "Nb word annotations: #{ts_cas.get_term_occ_annotations.count}"
  i = 0
  ts_cas.term_occ_annotations.each do |t|
    break if (i+=1) > 10
    puts "\t#{t.covered_text}[#{t.begin},#{t.end}]\t\tkey=> #{t.term_key}"
  end
end

Dir["/home/cram-d/Corpora/wind-energy/French/txt/**/*"][0...5].each do |p|
  stream.add_document(
    uri: p,
    text: IO.read(p)
  )
end

# Waits for the pipeline to finish and closes the stream
stream.flush

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/termsuite/rtermsuite. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [Apache 2.0 License](http://www.apache.org/licenses/).
