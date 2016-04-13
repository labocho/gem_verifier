require "tmpdir"
require "open-uri"
require "json"
require "open3"

module GemVerifier
  class Verifier
    attr_reader :name, :repository

    def self.verify(name, repository)
      new(name, repository).verify
    end

    def initialize(name, repository)
      @name, @repository = name, repository
    end

    def verify
      result = {}

      Dir.mktmpdir do |working_dir|
        Dir.chdir(working_dir) do
          log "Work in #{working_dir}"

          clone_repository

          each_version do |version|
            log "------------------------------"
            log "Verify #{version}"

            checkout_version(version)

            clean_gem
            download_gem(version)
            unpack_gem

            result[version] = diff
          end
        end
      end

      result
    end

    private
    def repo_dir
      "repo"
    end

    def gem_dir
      "gem"
    end

    def gem_file
      "gem.gem"
    end

    def clone_repository
      log "Clone repository #{repository} to #{repo_dir}"
      sh("git", "clone", repository, "#{repo_dir}")
    end

    def each_version
      log "Get gem versions"
      json = open("https://rubygems.org/api/v1/versions/#{name}.json", &:read)
      JSON.parse(json).each do |version|
        yield version["number"]
      end
    end

    def checkout_version(version)
      Dir.chdir(repo_dir) do
        sh("git", "checkout", "v#{version}")
      end
    end

    def clean_gem
      sh("rm", "-f", gem_file)
      sh("rm", "-rf", gem_dir)
    end

    def download_gem(version)
      log "Download gem #{version} to #{gem_file}"
      gem = open("https://rubygems.org/gems/#{name}-#{version}.gem", &:read)
      File.write(gem_file, gem)
    end

    def unpack_gem
      sh("gem", "unpack", gem_file)
    end

    def diff
      sh("diff", "-ru", repo_dir, gem_dir, exit_on_failure: false)
    end

    def log(message)
      $stderr.puts message
    end

    def sh(*args, exit_on_failure: true)
      log args.join(" ")
      out, err, status = Open3.capture3(*args)
      if exit_on_failure && !status.success?
        $stderr.puts err
        raise "Command failed: #{args.join(" ")}"
      end
      out
    end
  end
end
