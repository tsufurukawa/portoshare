class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # process files as they are uploaded:
  process :resize_to_fit => [500, 500]

  # default directory where uploaded files are stored (not for production / staging)
  def store_dir
    if Rails.env.test? || Rails.env.development?
      "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "#{Rails.env}/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    ActionController::Base.helpers.asset_path("https://s3-us-west-1.amazonaws.com/portoshare/images/default_project_image_original.png")
  end

  # white-list of allowed extensions
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
