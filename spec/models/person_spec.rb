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
  end
end
