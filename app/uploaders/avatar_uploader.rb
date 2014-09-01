class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Process files as they are uploaded:
  process :resize_to_fill => [170, 170]

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
    ActionController::Base.helpers.asset_path("/tmp/default_avatar_170.png")
  end

  # white-list of allowed extensions
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
