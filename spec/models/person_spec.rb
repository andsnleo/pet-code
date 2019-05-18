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
end
