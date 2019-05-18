class OwnershipValidator
  def initialize(animal)
    @animal = animal
    @person = animal.person
  end

  def validate
    validate_ownership_by_person_expenses
    validate_ownership_by_animal_kind
  end

  private

  def validate_ownership_by_person_expenses
    @animal.errors.add(:person, 'cannot have more animals') unless person_can_have_more_animals?
  end

  def validate_ownership_by_animal_kind
    case @animal.kind
    when 'Gato'
      @animal.errors.add(:person, 'cannot have cats') unless person_can_have_cats?
    when 'Andorinha'
      @animal.errors.add(:person, 'cannot have swallows') unless person_can_have_swallows?
    end
  end

  def person_can_have_more_animals?
    @person.monthly_cost_with_animals <= 1_000
  end

  def person_can_have_cats?
    !@person.name.start_with?('A')
  end

  def person_can_have_swallows?
    @person.over_18?
  end
end
