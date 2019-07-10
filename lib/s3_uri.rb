# encoding: utf-8

class S3URI
  require 'aws-sdk'

  attr_reader :file_name, :target_bucket, :options

  def initialize(file_name, target_bucket, options={})
    @file_name = file_name
    @target_bucket = target_bucket
    @options=options
  end

  def open(&block)
    if block_given?
      block.call(s3_file)
    else
      s3_file
    end
  end

  def to_s
    file_name.to_s
  end

  def to_str
    to_s
  end

  private

  def s3_file
    s3_bucket.objects[file_name]
  end

  def s3_bucket
    s3.buckets[target_bucket]
  end

  def s3
    Aws::S3.new(s3_options)
  end

  def s3_options
    opts = s3_options_defaults
    opts.merge!({s3_endpoint: s3_endpoint}) if s3_endpoint
    opts
  end

  def s3_options_defaults
    {
      access_key_id: access_key_id,
      secret_access_key: secret_access_key,
    }
  end

  def access_key_id
    access_key_id = options['S3_ACCESS_KEY_ID'] || ENV['S3_ACCESS_KEY_ID']
  end

  def secret_access_key
    secret_access_key = options['S3_SECRET_ACCESS_KEY'] || ENV['S3_SECRET_ACCESS_KEY']
  end

  def s3_endpoint
    s3_endpoint = options['S3_ENDPOINT'] || ENV['S3_ENDPOINT']
  end

end
