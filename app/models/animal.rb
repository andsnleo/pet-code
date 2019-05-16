class Animal < ActiveRecord::Base
  alias_attribute :owner, :person

  belongs_to :person
end
