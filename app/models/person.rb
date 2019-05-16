class Person < ActiveRecord::Base
  alias_attribute :pets, :animals

  has_many :animals

  private

  def can_have_more_pets?
    monthly_cost_with_pets <= 1_000
  end

  def monthly_cost_with_pets
    pets.present? ? pets.pluck(:monthly_cost).sum : 0
  end

  def can_have_cats?
    !name.start_with?('A')
  end

  def can_have_swallows?
    over_18?
  end

  def over_18?
    birthdate < 18.years.ago
  end
end
