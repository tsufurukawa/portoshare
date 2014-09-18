CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => Figaro.env.FOG_PROVIDER,
      :aws_access_key_id      => Figaro.env.AWS_ACCESS_KEY_ID,
      :aws_secret_access_key  => Figaro.env.AWS_SECRET_ACCESS_KEY,
      :region                 => Figaro.env.FOG_REGION
    }
    config.fog_directory  = Figaro.env.FOG_DIRECTORY
  else
    config.storage = :file # for development and test environments
    config.enable_processing = Rails.env.development? # no image processing in testing
  end
end