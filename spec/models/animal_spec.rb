require 'rails_helper'

describe Animal, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:person).required(false) }
  end

  describe 'validations' do
    describe '#name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    describe '#kind' do
      it { is_expected.to validate_presence_of(:kind) }
    end

    describe '#monthly_cost' do
      it { is_expected.to validate_presence_of(:monthly_cost) }
      it { is_expected.to validate_numericality_of(:monthly_cost).is_greater_than_or_equal_to(0) }
    end
  end
end
