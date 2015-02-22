module Traveler

  if v = RUBY_VERSIONS.find {|v| v.to_f == RUBY_VERSION.to_f}
    EFFECTIVE_RUBY_VERSION = v
  else
    assert_ruby_version_supported!(RUBY_VERSION)
  end

  [
    CONFIGFILE,
    GEMFILE
  ].each do |f|
    file = appdir(f)
    File.file?(file)     || fail("Looks like #{f} does not exists. Did you run `traveler init`?")
    File.readable?(file) || fail("Looks like #{f} is not readable")
  end

  %w[
    curl
    tar
    gzip
    cp
    rm
    find
    bundler
  ].each do |x|
    Traveler.const_set(x.upcase, %x[which #{x}].strip)
    next if $? && $?.exitstatus == 0
    fail("Could not find %s.
      Please make sure it is installed and in your PATH" % x)
  end

  Config.class_eval(File.read(CONFIGFILE_PATH))

  OPTED_PLATFORMS.any?                    || fail('Please specify at least one platform')
  const_defined?(:TRAVELING_RUBY_VERSION) || fail('Please specify the traveling_ruby_version')
  const_defined?(:FOLDER_NAME)            || fail('Please specify the folder_name')
end
