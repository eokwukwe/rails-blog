# frozen_string_literal: true

# ImageUploader
class ImageUploader < CarrierWave::Uploader::Base
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  if ENV['RAILS_ENV'] == 'test' || ENV['RAILS_ENV'] == 'development'
    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  if ENV['RAILS_ENV'] == 'production'
    include Cloudinary::CarrierWave
    process convert: 'png'

    def public_id
      if model.is_a?(User)
        "codeblog/users/#{model.username.to_s.downcase
        .gsub(/\W/, '-')}-#{Time.now.to_i}"
      elsif model.is_a?(Article)
        "codeblog/articles/#{model.slug}-#{Time.now.to_i}"
      end
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
