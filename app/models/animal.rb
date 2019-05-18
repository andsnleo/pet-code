class Animal < ActiveRecord::Base
  belongs_to :person, required: false

  validates :name, presence: true
  validates :kind, presence: true
  validates :monthly_cost, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validate do |animal|
    OwnershipValidator.new(animal).validate unless animal.person.nil?
  end
end
