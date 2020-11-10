module V1
  module Entities
    class UserEntity < Grape::Entity
      expose :id, :account_id
      expose :sex do |user|
        user.sex
      end
      expose :description, :profile_img, :twitter_url, :insta_url
    end
  end
end