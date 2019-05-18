require 'rails_helper'

RSpec.describe Animal, type: :model do
  describe 'validations' do
    describe 'person' do
      context 'when animal is a cat' do
        let(:animal) { Animal.create(name: 'Fantasma', kind: 'Gato', monthly_cost: 499.99) }

        context 'and person has name starting with any letter but A' do
          let(:person) do
            Person.create(
              name: 'João das Neves',
              identity_document: '555555555',
              birthdate: '1993-12-30'
            )
          end

          before { person.animals << animal }

          it { expect(animal).to be_valid }
        end

        context 'and person has name starting with A' do
          let(:person) do
            Person.create(
              name: 'Arya Stark',
              identity_document: '555555555',
              birthdate: '1993-12-30'
            )
          end

          before { person.animals << animal }

          it { expect(animal).to be_invalid }
        end
      end

      context 'when animal is a swallow' do
        let(:animal) { Animal.create(name: 'Fantasma', kind: 'Andorinha', monthly_cost: 499.99) }

        before { allow(Date).to receive(:today).and_return(Date.parse('2018-07-20')) }

        context 'and person is under 18 years old' do
          let(:person) do
            Person.create(
              name: 'Arya Stark',
              identity_document: '555555555',
              birthdate: Date.today + 1.day - 18.years
            )
          end

          before { person.animals << animal }

          it { expect(animal).to be_invalid }
        end

        context 'and person is 18 years old' do
          let(:person) do
            Person.create(
              name: 'Arya Stark',
              identity_document: '555555555',
              birthdate: Date.today - 18.years
            )
          end

          before { person.animals << animal }

          it { expect(animal).to be_valid }
        end

        context 'and person is over 18 years old' do
          let(:person) do
            Person.create(
              name: 'Arya Stark',
              identity_document: '555555555',
              birthdate: Date.today - 1.day - 18.years
            )
          end

          before { person.animals << animal }

          it { expect(animal).to be_valid }
        end
      end

      context 'when animal is of any kind' do
        let(:animal) { Animal.create(name: 'Fantasma', kind: 'Cachorro', monthly_cost: 499.99) }

        context 'and person already spends more than R$ 1.000 with other animals' do
          let(:person) do
            Person.create(
              name: 'João das Neves',
              identity_document: '555555555',
              birthdate: '1993-12-30',
              animals: [animal.dup, animal.dup, animal.dup]
            )
          end

          before { person.animals << animal }

          it { expect(animal).to be_invalid }
        end

        context 'and person spends less than R$ 1.000 with other animals' do
          let(:person) do
            Person.create(
              name: 'João das Neves',
              identity_document: '555555555',
              birthdate: '1993-12-30',
              animals: [animal.dup, animal.dup]
            )
          end

          before { animal.person = person }

          it { expect(animal).to be_valid }
        end
      end
    end
  end
end
