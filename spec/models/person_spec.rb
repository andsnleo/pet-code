require 'rails_helper'

describe Person, type: :model do
  let(:person) do
    Person.create(
      name: 'João das Neves',
      identity_document: 123_456_789,
      birthdate: '1992-07-19'
    )
  end

  describe '#over_18?' do
    before { allow(Time).to receive(:now).and_return(Time.parse('2018-07-18')) }

    context 'when the person was born less than 18 years ago' do
      let(:person) do
        Person.create(
          name: 'João das Neves',
          identity_document: 123_456_789,
          birthdate: '2000-07-19'
        )
      end

      it 'returns false' do
        expect(person.over_18?).to be(false)
      end
    end

    context 'when the person was born exactly 18 years ago' do
      let(:person) do
        Person.create(
          name: 'João das Neves',
          identity_document: 123_456_789,
          birthdate: '2000-07-18'
        )
      end

      it 'returns true' do
        expect(person.over_18?).to be(true)
      end
    end

    context 'when the person was born more than 18 years ago' do
      let(:person) do
        Person.create(
          name: 'João das Neves',
          identity_document: 123_456_789,
          birthdate: '2000-07-17'
        )
      end

      it 'returns true' do
        expect(person.over_18?).to be(true)
      end
    end
  end
end
