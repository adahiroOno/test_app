class V1::Resources::Users < Grape::API

  helpers V1::Helpers::UserHelper

  resource :users do
    desc 'ユーザー新規作成'
    params do
      requires :account_id, type: String, default: "dearhero", desc: 'アカウントID'
      requires :sex_id, type: Integer, default: 1, desc: '性別'
      optional :description, type: String, default: 'フォローお願いします', desc: '自己紹介'
      optional :profile_img, type: File, desc: 'プロフィール画像'
      optional :twitter_url, type: String, default: 'https://twitter.com/twitter', desc: 'Twitter URL'
      optional :insta_url, type: String, default: 'https://www.instagram.com/instagram/', desc: 'Instagram URL'
    end

    post 'create' do
      ActiveRecord::Base.transaction do
        user = User.new(declared(params, include_missing: false))
        if user.save!
         {success: :true}
        else
         {error: user.errors.messages}
        end
      end
    end

    desc 'ユーザー更新'
    params do
      requires :account_id, type: String, default: "dearhero", desc: 'アカウントID'
      requires :sex_id, type: Integer, default: 1, desc: '性別'
      optional :description, type: String, default: 'フォローお願いします', desc: '自己紹介'
      optional :profile_img, type: File, desc: 'プロフィール画像'
      optional :twitter_url, type: String, default: 'https://twitter.com/twitter', desc: 'Twitter URL'
      optional :insta_url, type: String, default: 'https://www.instagram.com/instagram/', desc: 'Instagram URL'
    end

    patch ':id/update' do
      ActiveRecord::Base.transaction do
        user = find_user(params[:id])
        exist_user?(user)
        if user.update!(declared(params, include_missing: false))
         {success: :true}
        else
         {error: user.errors.messages}
        end
      end
    end

    desc 'ユーザー削除'
    delete ':id/delete' do
      user = find_user(params[:id])
      exist_user?(user)
      if user.destroy
        {success: :true}
      else
       {error: user.errors.messages}
      end
    end

    desc 'ユーザー全件取得'
    get  do
       present User.all, with: V1::Entities::UserEntity
    end

    desc 'ユーザー1件取得'
    get ':id' do
      user = find_user(params[:id])
      exist_user?(user)
      present user, with: V1::Entities::UserEntity
    end
  end
end