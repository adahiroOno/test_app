#-*- encoding: utf-8 -*-
# [usage] rails runner script/dummy_data.rb
class DummyData

  def self.excute
    ActiveRecord::Base.transaction do

      end
    end
  end
end
  
DummyData.excute