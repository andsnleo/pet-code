class Animal < ActiveRecord::Base
  belongs_to :person, required: false

  validates :name, presence: true
  validates :kind, presence: true
  validates :monthly_cost, presence: true, numericality: { greater_than_or_equal_to: 0 }

  with_options if: -> { person.present? } do
    validate :validate_if_person_can_have_more_animals?
    validate :validate_if_person_can_have_cats?
    validate :validate_if_person_can_have_swallows?
  end

  private

  def validate_if_person_can_have_more_animals?
    return if person.can_have_more_animals?

    errors.add(:person, 'cannot have more animals')
  end

  def validate_if_person_can_have_cats?
    return if person.can_have_cats?

    errors.add(:person, 'cannot have cats')
  end

  def validate_if_person_can_have_swallows?
    return if person.can_have_swallows?

    errors.add(:person, 'cannot have swallows')
  end
end
