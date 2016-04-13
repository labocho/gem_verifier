# GemVerifier

Compare gem on rubygems.org and source on git repository as follow.

1. Make temporary directory.
2. Clone repository.
3. List all gem versions.
4. Download gem from rubygems.org and unpack.
5. Checkout vesion tag like `v0.1.0`.
6. Get diff by `diff -ru`.
7. Print report to stdout as JSON.
8. Remove temporary directory.

## Installation

    $ git clone https://github.com/labocho/gem_verifier.git
    $ cd gem_verifier
    $ rake install

## Usage

    $ gem_verifier GEM_NAME GEM_REPOSITORY_URL

Example:

    $ gem_verifier pagehook-rails https://github.com/labocho/pagehook-rails.git
    Work in /var/folders/wx/5tjkwlx96tx38cpj2d_fn5z80000gn/T/d20160413-45274-1d9s4th
    Clone repository https://github.com/labocho/pagehook-rails.git to repo
    git clone https://github.com/labocho/pagehook-rails.git repo
    Get gem versions
    ------------------------------
    Verify 0.0.5
    git checkout v0.0.5
    rm -f gem.gem
    rm -rf gem
    Download gem 0.0.5 to gem.gem
    gem unpack gem.gem
    diff -ru repo gem
    ------------------------------
    Verify 0.0.4
    git checkout v0.0.4
    rm -f gem.gem
    rm -rf gem
    Download gem 0.0.4 to gem.gem
    gem unpack gem.gem
    diff -ru repo gem
    ------------------------------
    Verify 0.0.3
    git checkout v0.0.3
    rm -f gem.gem
    rm -rf gem
    Download gem 0.0.3 to gem.gem
    gem unpack gem.gem
    diff -ru repo gem
    ------------------------------
    Verify 0.0.2
    git checkout v0.0.2
    rm -f gem.gem
    rm -rf gem
    Download gem 0.0.2 to gem.gem
    gem unpack gem.gem
    diff -ru repo gem
    ------------------------------
    Verify 0.0.1
    git checkout v0.0.1
    rm -f gem.gem
    rm -rf gem
    Download gem 0.0.1 to gem.gem
    gem unpack gem.gem
    diff -ru repo gem
    {
      "0.0.5": "Only in repo: .git\nOnly in repo: .gitignore\nOnly in repo: Gemfile\nOnly in repo: Gemfile.lock\nOnly in repo: pagehook-rails.gemspec\nOnly in repo: script\nOnly in repo: spec\n",
      "0.0.4": "Only in repo: .git\nOnly in repo: .gitignore\nOnly in repo: Gemfile\nOnly in repo: Gemfile.lock\nOnly in repo: pagehook-rails.gemspec\nOnly in repo: script\nOnly in repo: spec\n",
      "0.0.3": "Only in repo: .git\nOnly in repo: .gitignore\nOnly in repo: Gemfile\nOnly in repo: Gemfile.lock\nOnly in repo: pagehook-rails.gemspec\nOnly in repo: script\nOnly in repo: spec\n",
      "0.0.2": "Only in repo: .git\nOnly in repo: .gitignore\nOnly in repo: Gemfile\nOnly in repo: Gemfile.lock\nOnly in repo: pagehook-rails.gemspec\nOnly in repo: script\nOnly in repo: spec\n",
      "0.0.1": "Only in repo: .git\nOnly in repo: .gitignore\nOnly in repo: Gemfile\nOnly in repo: Gemfile.lock\nOnly in repo: pagehook-rails.gemspec\nOnly in repo: script\nOnly in repo: spec\n"
    }

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gem_verifier.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

