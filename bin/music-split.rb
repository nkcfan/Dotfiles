#!/usr/bin/env ruby
require "shellwords"

fn = Shellwords.escape(ARGV[0])
fbase = File.basename(fn, '.ape')
fbase = File.basename(fbase, '.wav')
# p base

p cmd = "avconv -i #{fn} #{fbase}.flac"
`#{cmd}`

p cmd = "mkdir -p #{fbase} && cuebreakpoints #{fbase}.cue | shnsplit -o flac #{fbase}.flac"
`#{cmd} -d #{fbase}/`

p cmd = "cuetag #{fbase}.cue #{fbase}/split-track*.flac"
`#{cmd}`

# p cmd = "rm #{fbase}.flac"
# `#{cmd}`
