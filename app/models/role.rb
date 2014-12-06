class Role < ActiveRecord::Base

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def self.find_or_create_by_name(name)
      find_by_name(name) || create(:name => name)
    end
    
  end

end