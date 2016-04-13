require "json"

module GemVerifier
  class CLI
    def self.start(argv)
      new.start(argv)
    end

    def start(argv)
      unless argv.size == 2
        $stderr.puts "Usage: #{$0} GEM_NAME REPOSITORY"
        exit 1
      end
      name, repository = argv
      result = Verifier.verify(name, repository)
      puts JSON.pretty_generate(result)
    end
  end
end
