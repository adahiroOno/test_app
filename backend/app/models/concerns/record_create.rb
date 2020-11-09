require 'active_support'

module RecordCreate
  extend ActiveSupport::Concern
  included do
    def self.create_once(args)
      unless self.exists?(args[:id])
        record    = self.new(args)
        record.id = args[:id]
        record.save!
      end
    end
  end
end