module Traveler
  class Wrapper
    include Util

    def initialize ruby_version, name, cmd, block
      @ruby_version, @name, @cmd, @block = ruby_version, name, cmd, block
      write if writeable?
    end

    def write
      File.open(file, 'w') {|f| f << render_wrapper}
      FileUtils.chmod('+x', file)
    end

    def writeable?
      if File.exists?(file) && File.read(file) !~ /#{SIGNATURE}/m
        puts warn('
        "%s" file exists and is not a Traveler wrapper.
        Use another file or delete/rename this one and (re)run `traveler wrap`' % file)
        return false
      end
      true
    end

    def locals
      {
        signature:              SIGNATURE,
        folder_name:            FOLDER_NAME,
        traveling_ruby_version: TRAVELING_RUBY_VERSION,
        wrapper_ruby_version:   @ruby_version
      }
    end

    def cmd
      return @block.call if @block
      render_cmd(@cmd)
    end

    def render_wrapper
      Mustache.render(wrapper_template, locals.merge(cmd: cmd))
    end

    def render_cmd cmd
      Mustache.render(cmd_template, locals.merge(cmd: cmd))
    end

    def wrapper_template
      File.read(skeldir('wrapper.sh'))
    end

    def cmd_template
      File.read(skeldir('cmd.sh'))
    end

    def file
      @name
    end
  end
end
