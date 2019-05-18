FactoryBot.define do
  factory :person do
    name { 'João das Neves' }
    identity_document { '555555555' }
    birthdate { Date.today - 25.years }

    factory :person_with_animals do
      animals { create(:animal, 3) }
    end

    factory :person_who_cannot_have_cats do
      name { 'Arya Stark' }
    end

    factory :person_who_cannot_have_swallows do
      birthdate { Date.tomorrow - 18.years }
    end
  end
end
