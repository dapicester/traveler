require 'traveler/core_ext'

module Traveler
  module Util

    def appdir *args
      File.join(PWD, *args.flatten.map(&:to_s))
    end

    def rubydir *args
      appdir(FOLDER_NAME, *args)
    end

    def skeldir *args
      File.join(SKEL_PATH, *args.flatten.map(&:to_s))
    end

    {
      success:      [0, 32],
      bold_success: [1, 32],
      info:         [0, 36],
      bold_info:    [1, 36],
      warn:         [0, 35],
      bold_warn:    [1, 35],
      error:        [0, 31],
      bold_error:   [1, 31],
    }.each_pair do |m,(esc,color)|
      define_method m do |*args|
        args.map {|a| "\e[%i;%im%s\e[0m" % [esc, color, a]}.join
      end
    end

    def fail reason = nil, caller = nil
      buffer = []
      buffer << error(:error.icon, ' ', reason) if reason
      buffer << info('  in %s' % caller.to_s.gsub(/.*:(\d+):in.*/, CONFIGFILE + ':\1')) if caller
      puts(*buffer) if buffer.any?
      exit(1)
    end

    def sh *args
      puts '$ ' << info(cmd = args.map(&:to_s).join(" "))
      PTY.spawn cmd do |r, w, pid|
        begin
          r.sync
          r.each_char {|c| print(c)}
        rescue Errno::EIO => e
        ensure
          _, status = Process.wait2(pid)
          fail('Exiting...') unless status == 0
        end
      end
    end
  end
end
