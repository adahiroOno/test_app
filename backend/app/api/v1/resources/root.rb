#-*- encoding: utf-8 -*-
module V1
  module Resources
    class Root < Grape::API
      version 'v1'
      format :json

      if defined? GrapeSwaggerRails
        add_swagger_documentation add_version: true
        # ,host: 'http://localhost:3000' if Rails.env.development?
      end
    end
  end
end