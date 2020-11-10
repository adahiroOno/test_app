module V1
  module Helpers
    module UserHelper
      extend Grape::API::Helpers
      def find_user(user_id)
        User.find_by(id: user_id)
      end

      def exist_user?(user)
       error!({error: 'user not found'}) if user.blank?
      end
    end
  end
end