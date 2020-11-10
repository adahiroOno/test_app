class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :sex
  mount_uploader :profile_img, ProfileImgUploader
end