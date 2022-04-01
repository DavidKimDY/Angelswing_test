CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     "#{ENV["AWS_ACCESS_ID"]}",
        aws_secret_access_key: "#{ENV["AWS_ACCESS_SECRET_KEY"]}",
        region:                "#{ENV["AWS_REGION"]}",
        endpoint:              "#{ENV["AWS_S3_END_POINT"]}"
    }
    config.fog_directory  = 'angelswing-api-test'
    config.fog_public     = true
    config.fog_attributes = { }
    
    config.remove_previously_stored_files_after_update = true
end
