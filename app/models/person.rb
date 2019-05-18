class Person < ActiveRecord::Base
  has_many :animals, -> { distinct }

  validates :name, presence: true
  validates :identity_document, presence: true, length: { is: 9 }, format: { with: /[0-9]+/ }
  validates :birthdate, presence: true

  def monthly_cost_with_animals
    animals.map(&:monthly_cost).sum
  end

  def can_have_more_animals?
    monthly_cost_with_animals <= 1_000
  end

  def can_have_cats?
    !name.start_with?('A')
  end

  def can_have_swallows?
    over_18?
  end

  private

  def over_18?
    birthdate <= Date.today - 18.years
  end
end
