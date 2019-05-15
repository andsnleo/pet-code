DATASET = [
  {
    person: { name: 'Johnny Cash', identity_document: 555555555, birthdate: '1932-02-26' },
    animals: [
      { name: 'Pé de Pano', kind: 'Cavalo', monthly_cost: 199.99 }
    ]
  },
  {
    person: { name: 'Sid Vicious', identity_document: 555555555, birthdate: '1957-05-10' },
    animals: [
      { name: 'Rex', kind: 'Cachorro', monthly_cost: 99.99 }
    ]
  },
  {
    person: { name: 'Axl Rose', identity_document: 555555555, birthdate: '1962-02-06' },
    animals: [
      { name: 'Ajudante do Papai Noel', kind: 'Cachorro', monthly_cost: 99.99 }
    ]
  },
  {
    person: { name: 'Joey Ramone', identity_document: 555555555, birthdate: '1951-05-19' },
    animals: [
      { name: 'Rex', kind: 'Papagaio', monthly_cost: 103.99 }
    ]
  },
  {
    person: { name: 'Bruce Dickinson', identity_document: 555555555, birthdate: '1958-08-07' },
    animals: [
      { name: 'Flora', kind: 'Lhama', monthly_cost: 103.99 }
    ]
  },
  {
    person: { name: 'Kurt Cobain', identity_document: 555555555, birthdate: '1967-02-20' },
    animals: [
      { name: 'Dino', kind: 'Iguana', monthly_cost: 177.99 }
    ]
  },
  {
    person: { name: 'Elvis Presley', identity_document: 555555555, birthdate: '2008-08-17' },
    animals: [
      { name: 'Lassie', kind: 'Ornitorrinco', monthly_cost: 407.99 }
    ]
  }
].freeze

DATASET.each do |data|
  person = Person.create(data[:person])
  data[:animals].each { |animal| Animal.create({ **animal, owner: person }) }
end
