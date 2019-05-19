require 'rails_helper'

describe Person, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:animals) }
  end

  describe 'validations' do
    describe '#name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    describe '#identity_document' do
      it { is_expected.to validate_presence_of(:identity_document) }
      it { is_expected.to validate_length_of(:identity_document).is_equal_to(9) }

      describe 'format' do
        it { is_expected.to allow_value('123456789').for(:identity_document) }
        it { is_expected.to_not allow_value('123ABC789').for(:identity_document) }
        it { is_expected.to_not allow_value('123.456.789').for(:identity_document) }
      end
    end
  end

  describe '#monthly_cost_with_animals' do
    let(:person) do
      create(:person, animals: Array.new(4) { create(:animal, monthly_cost: 150.00) })
    end

    it 'returns the total monthly cost with all animals' do
      expect(person.monthly_cost_with_animals).to eq(600.00)
    end
  end

  describe '#over_18?' do
    context 'when person was born less than 18 years ago' do
      let(:person) { create(:person, birthdate: Date.tomorrow - 18.years) }

      it { expect(person.over_18?).to be(false) }
    end

    context 'when person was born exactly 18 years ago' do
      let(:person) { create(:person, birthdate: Date.today - 18.years) }

      it { expect(person.over_18?).to be(true) }
    end

    context 'when person was born more than 18 years ago' do
      let(:person) { create(:person, birthdate: Date.yesterday - 18.years) }

      it { expect(person.over_18?).to be(true) }
    end
  end
end
