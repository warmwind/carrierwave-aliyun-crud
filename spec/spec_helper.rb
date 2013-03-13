#encoding: utf-8
require 'rubygems'
require 'rspec'
require 'rspec/autorun'
require 'rails'
require 'active_record'
require "carrierwave"
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mini_magick'
require 'uri'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "carrierwave-aliyun-crud"


module Rails
  class <<self
    def root
      [File.expand_path(__FILE__).split('/')[0..-3].join('/'),"spec"].join("/")
    end
  end
end

ActiveRecord::Migration.verbose = false

# 测试的时候需要修改这个地方
CarrierWave.configure do |config|
  config.storage = :aliyun
  config.aliyun_access_id = "n4R7XBeTZqd2blQz"
  config.aliyun_access_key = 'WiMTt42rLMT9bPGfGaEaNlzHahG9du'
  config.aliyun_bucket = "carrierwave-jp"
  config.aliyun_internal = false
end

def load_file(fname)
  File.open([Rails.root,fname].join("/"))
end