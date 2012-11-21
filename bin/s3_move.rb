#!/usr/bin/ruby
require 'rubygems'
require 'aws-sdk'

# parse shell thing as ruby thing
eval File.open( File.expand_path('~/.s3passwd') ).read.gsub("\n", "\"\n").gsub("=", "=\"")

AWS.config :access_key_id => ACCESS_KEY_ID,
           :secret_access_key => SECRET_ACCESS_KEY

s3 = AWS::S3.new

frombucket = s3.buckets[ ARGV.shift ]
tobucket = s3.buckets[ ARGV.shift ]
files = ARGV

files.each do |f|
  obj1 = frombucket.objects[ f ]
  obj2 = tobucket.objects[ f ]

  obj1.move_to(obj2)
end
