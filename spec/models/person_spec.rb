require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'validations' do
    context 'name' do
      let(:person) { Person.new(identity_document: '555555555', birthdate: '1993-12-30') }

      context 'when person has a name' do
        before { person.name = 'João das Neves' }

        it { expect(person).to be_valid }
      end

      context 'when person has no name' do
        it { expect(person).to be_invalid }
      end
    end

    context 'identity_document' do
      let(:person) { Person.new(name: 'João das Neves', birthdate: '1993-12-30') }

      context 'when person has an identity_document' do
        context 'that is 9-digit long' do
          before { person.identity_document = '123456789' }

          it { expect(person).to be_valid }
        end

        context 'that is more than 9-digit long' do
          before { person.identity_document = '1234567890' }

          it { expect(person).to be_invalid }
        end

        context 'that is less than 9-digit long' do
          before { person.identity_document = '12345678' }

          it { expect(person).to be_invalid }
        end
      end

      context 'when person has no identity_document' do
        it { expect(person).to be_invalid }
      end
    end

    context 'birthdate' do
      let(:person) { Person.new(name: 'João das Neves', identity_document: '555555555') }

      context 'when person has no birthdate' do
        it { expect(person).to be_invalid }
      end

      context 'when person has birthdate' do
        before { person.birthdate = '1993-12-30' }

        it { expect(person).to be_valid }
      end
    end

    context 'animals' do
      context 'when person tries to adopt any animal' do
        let(:person) do
          Person.create(
            name: 'João das Neves',
            identity_document: '555555555',
            birthdate: '1993-12-30'
          )
        end
        let(:dog) { Animal.new(name: 'Fantasma', kind: 'Gato', monthly_cost: 499.99) }
        let(:cat) { Animal.new(name: 'Fantasma', kind: 'Gato', monthly_cost: 500.01) }
        let(:swallow) { Animal.new(name: 'Fantasma', kind: 'Andorinha', monthly_cost: 1000.01) }

        context 'having had no animals before' do
          before { person.animals << swallow }

          it { expect(person).to be_valid }
        end

        context 'spending less than R$ 1.000 with other pets' do
          before do
            person.animals << dog
            person.save
            person.animals << swallow
          end

          it { expect(person).to be_valid }
        end

        context 'spending more than R$ 1.000 with other pets' do
          before do
            person.animals << swallow
            person.save
            person.animals << cat
          end

          it { expect(person).to be_invalid }
        end
      end

      context 'when person tries to adopt a cat' do
        let(:person) do
          Person.new(
            name: 'João das Neves',
            identity_document: '555555555',
            birthdate: '1993-12-30'
          )
        end
        let(:cat) { Animal.new(name: 'Fantasma', kind: 'Gato', monthly_cost: 500.01) }

        context 'and has a name starting with any letter but A' do
          before { person.animals << cat }

          it { expect(person).to be_valid }
        end

        context 'and has a name starting with A' do
          before do
            person.name = 'Arya Stark'
            person.animals << cat
          end

          it { expect(person).to be_invalid }
        end
      end

      context 'when person tries to adopt a swallow' do
        let(:person) do
          Person.new(
            name: 'João das Neves',
            identity_document: '555555555',
            birthdate: 18.years.ago
          )
        end
        let(:swallow) { Animal.new(name: 'Fantasma', kind: 'Andorinha', monthly_cost: 500.01) }

        context 'and is over 18 years old' do
          before { person.animals << swallow }

          it { expect(person).to be_valid }
        end

        context 'and is under 18 years old' do
          before do
            person.birthdate = 18.years.ago + 1.day
            person.animals << swallow
          end

          it { expect(person).to be_invalid }
        end
      end
    end
  end
end
