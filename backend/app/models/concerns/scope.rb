#-*- encoding: utf-8 -*-
require 'active_support'

module Scope
  extend ActiveSupport::Concern
  included do
    # category取得
    scope :to_label, -> (name) { find_by(name: name).label }
    scope :to_id, -> (name) { find_by(name: name).id }
    scope :label_to_id, -> (label) { find_by(label: label).id }
  end
end