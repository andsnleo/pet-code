class Person < ActiveRecord::Base
  has_many :animals

  validates :name, presence: true
  validates :identity_document, presence: true, length: { is: 9 }, format: { with: /\A[0-9]+\z/ }
  validates :birthdate, presence: true

  def monthly_cost_with_animals
    animals.sum(:monthly_cost)
  end

  def over_18?
    birthdate <= Date.today - 18.years
  end
end
