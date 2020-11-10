require 'rails_helper'

describe "USER API", type: :request do
  before do
      10.times do
        User.create(
          account_id: Faker::Twitter.screen_name.slice!(1..15),
          sex_id: Faker::Number.within(range: 1..3),
          description: Faker::Twitter.user[:description],
          profile_img: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.png')),
          twitter_url: Faker::Internet.unique.url,
          insta_url: Faker::Internet.unique.url,
        )
      end
  end

  it "ユーザー全件取得" do
    get "/api/v1/users"
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body.size).to eq 10
    expect(body).to be_an_instance_of Array
    body.each { |u|
      u.delete('created_at')
      u.delete('updated_at')
      u['sex_id'] = u['sex']['attributes']['id']
      u['profile_img'] = File.basename(u['profile_img']['url'])
      u.delete('sex')
      expect(User.find_by(u)).to_not be_nil
    }
  end

  it "ユーザー1件取得" do
    id = Faker::Number.within(range: User.minimum(:id)..User.maximum(:id))
    get "/api/v1/users/#{id}"
    expect(response.status).to eq 200

    body = JSON.parse(response.body)
    expect(body).to be_an_instance_of Hash

    body.delete('created_at')
    body.delete('updated_at')
    body['sex_id'] = body['sex']['attributes']['id']
    body['profile_img'] = File.basename(body['profile_img']['url'])
    body.delete('sex')

    expect(User.find_by(body)).to_not be_nil
  end


  it 'ユーザー新規作成' do
    post_params = {
      account_id: Faker::Twitter.screen_name.slice!(1..15),
      sex_id: Faker::Number.within(range: 1..3),
      description: Faker::Twitter.user[:description],
      profile_img: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.png')),
      twitter_url: Faker::Internet.unique.url,
      insta_url: Faker::Internet.unique.url,
    }

    post "/api/v1/users/create", params: post_params
    expect(response.status).to eq 201
  end

  it 'ユーザー更新' do
    user_id = User.limit(10).sample.id
    post_params = {
      account_id: Faker::Twitter.screen_name.slice!(1..15),
      sex_id: Faker::Number.within(range: 1..3),
      description: Faker::Twitter.user[:description],
      profile_img: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.png')),
      twitter_url: Faker::Internet.unique.url,
      insta_url: Faker::Internet.unique.url,
    }

    patch "/api/v1/users/#{user_id}/update", params: post_params
    expect(response.status).to eq 200
  end
end