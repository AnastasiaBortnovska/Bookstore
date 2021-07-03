require "shrine"
require "shrine/storage/s3"
require "shrine/plugins/url_options"
 
s3_options = { 
  bucket:            "bookstore-bortnovska", 
  region:            "eu-central-1", 
  access_key_id:     Rails.application.credentials.dig(:aws, :access_key_id),
  secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
}
 
Shrine.storages = { 
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options), # temporary 
  store: Shrine::Storage::S3.new(**s3_options),                  # permanent 
}

Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :derivatives
Shrine.plugin :default_url
