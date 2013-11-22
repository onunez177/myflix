CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV["AWS_ACCESS_KEY"],                        # required
      :aws_secret_access_key  => ENV["AWS_SECRET_KEY"],                        # required
    }
    config.fog_directory  = 'paul-myflix/images'                     # required
  else
    config.storage = :file 
  end
end