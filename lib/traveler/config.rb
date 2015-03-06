module Traveler
  module Config
    extend Util
    extend self

    def assert_ruby_version_supported! version, caller = nil
      versions = 'Please use %s' % RUBY_VERSIONS.join(' or ')
      version.to_s.split('.').size == 3 || fail('Invalid Ruby version: "%s"
        %s' % [version, versions], caller)
      return true if RUBY_VERSIONS.include?(version)
      fail('Ruby %s not supported. %s' % [version, versions], caller)
    end

    def assert_traveling_ruby_version_supported! version, caller = nil
      return true if TRAVELING_RUBY_VERSIONS.include?(version)
      fail('traveling-ruby %s not supported. Please use %s' % [version, TRAVELING_RUBY_VERSIONS.join(' or ')], caller)
    end

    def assert_platform_supported! platform, caller = nil
      return true if PLATFORMS.include?(platform.to_s)
      fail('"%s" platform not supported' % platform, caller)
    end

    def platforms *platforms
      platforms.flatten!
      called_from = caller[0]
      platforms.each {|p| assert_platform_supported!(p, called_from)}
      OPTED_PLATFORMS.concat(platforms)
    end

    def wrapper name, ruby_version, cmd = nil, &block
      assert_ruby_version_supported!(ruby_version, caller[0])
      WRAPPERS[name.to_s.freeze] = [ruby_version.to_s.freeze, cmd.to_s.freeze, block].freeze
    end

    def traveling_ruby_version version
      assert_traveling_ruby_version_supported!(version, caller[0])
      Traveler.const_set(:TRAVELING_RUBY_VERSION, version.to_s.freeze)
    end

    def folder_name name
      Traveler.const_set(:FOLDER_NAME, name.to_s.freeze)
    end
  end
end

require 'traveler/prerequisites'
require 'traveler/runtime'
require 'traveler/bundler'
require 'traveler/gem'
require 'traveler/wrapper'
