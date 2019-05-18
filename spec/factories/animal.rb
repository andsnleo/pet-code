FactoryBot.define do
  factory :animal do
    name { 'Fantasma' }
    kind { 'Cachorro' }
    monthly_cost { 499.99 }
    person

    factory :cat do
      kind { 'Gato' }
    end

    factory :swallow do
      kind { 'Andorinha' }
    end
  end
end
