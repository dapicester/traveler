#!/usr/bin/env bash
{{signature}}
set -e
cd "$(cd $(dirname "$0") && pwd)"

if [[ `uname -s` =~ inux ]]; then
  arch="linux-$(uname -m)"
else
  arch="osx"
fi

unset  BUNDLE_IGNORE_CONFIG

export RUBY_VERSION="{{wrapper_ruby_version}}"
export RUBY_ROOT="{{folder_name}}/traveling-ruby-{{traveling_ruby_version}}-$RUBY_VERSION-$arch/"
export BUNDLE_GEMFILE="$RUBY_ROOT/vendor/Gemfile"

{{{cmd}}}
