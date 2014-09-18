class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Process files as they are uploaded:
  process :resize_to_fill => [170, 170]

  version :thumb do
    process :resize_to_fill => [35, 35]
  end

  # default directory where uploaded files are stored (not for production / staging)
  def store_dir
    if Rails.env.test?
      "uploads/test/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    if version_name == :thumb
      ActionController::Base.helpers.asset_path("https://s3-us-west-1.amazonaws.com/portoshare/images/thumb_default_avatar_170.png")
    else
      ActionController::Base.helpers.asset_path("https://s3-us-west-1.amazonaws.com/portoshare/images/default_avatar_170.png")
    end
  end

  # white-list of allowed extensions
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
