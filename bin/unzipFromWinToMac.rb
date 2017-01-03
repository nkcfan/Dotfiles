#!/usr/bin/env ruby

require 'rubygems'
require 'zip'
require 'iconv'
require 'fileutils'

## Borrowed from https://github.com/jiang-bo/codingforfun/blob/master/ruby/utils/unzipFromWinToMac.rb

# To unzip zipfile which zip in GBK to UTF-8.
#
# When you zip a file on Windows, it will encode in GBK default.
# Then you unzip it on Mac OSX which use unicode default, it will be wrong.
# This code is used to fix this problem:)
#
# @Author: jiang-bo

Zip::InputStream.open(ARGV[0]){
  |io|
  while(entry = io.get_next_entry)
    begin
      name=Iconv.iconv("UTF-8","GBK", entry.name)[0]
    rescue
      puts "Failed: #{entry.name}"
      next
    end
    
    dirname = File.dirname(name)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end    
    
    if name.end_with?('/')
      #FileUtils.mkdir_p(name.to_s)
    else
      begin
        entry.extract(name.to_s)
      rescue Zip::DestinationFileExistsError
        next
      end
    end
  end
}

