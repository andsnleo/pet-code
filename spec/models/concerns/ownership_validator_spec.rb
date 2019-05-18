require 'rails_helper'

describe OwnershipValidator, type: :concern do
  describe '#validate' do
    describe 'ownership by person expenses' do
      context 'when person has no animals' do
        let(:person) { create(:person) }

        context 'and tries to adopt one costing < 1.000/month' do
          let(:animal) { build(:animal, monthly_cost: 999.99) }

          before { animal.person = person }

          it 'validates the ownership' do
            expect(animal).to be_valid
            expect(animal.errors[:person]).to_not include('cannot have more animals')
          end
        end

        context 'and tries to adopt one costing 1.000/month' do
          let(:animal) { create(:animal, monthly_cost: 1_000.00) }

          before { animal.person = person }

          it 'validates the ownership' do
            expect(animal).to be_valid
            expect(animal.errors[:person]).to_not include('cannot have more animals')
          end
        end

        context 'and tries to adopt one costing > 1.000/month' do
          let(:animal) { create(:animal, monthly_cost: 1_000.01) }

          before { animal.person = person }

          it 'validates the ownership' do
            expect(animal).to be_valid
            expect(animal.errors[:person]).to_not include('cannot have more animals')
          end
        end
      end

      context 'when person already has animals' do
        context 'and tries to adopt a new one' do
          let(:person) { create(:person) }
          let(:another_animal) { create(:animal) }

          context 'but spends less than 1.000 with them' do
            before do
              person.animals << Array.new(3) { create(:animal, monthly_cost: 333.33) }
              person.save
              another_animal.person = person
            end

            it 'validates the ownership' do
              expect(another_animal).to be_valid
              expect(another_animal.errors[:person]).to_not include('cannot have more animals')
            end
          end

          context 'but spends 1.000 with them' do
            before do
              person.animals << Array.new(2) { create(:animal, monthly_cost: 500.00) }
              person.save
              another_animal.person = person
            end

            it 'validates the ownership' do
              expect(another_animal).to be_valid
              expect(another_animal.errors[:person]).to_not include('cannot have more animals')
            end
          end

          context 'but spends more than 1.000 with them' do
            before do
              person.animals << Array.new(2) { create(:animal, monthly_cost: 500.01) }
              person.save
              another_animal.person = person
            end

            it 'invalidates the ownership' do
              expect(another_animal).to be_invalid
              expect(another_animal.errors[:person]).to include('cannot have more animals')
            end
          end
        end
      end
    end

    describe 'ownership by animal kind' do
      context 'when animal is a cat' do
        let(:animal) { create(:cat) }

        context 'and person has a name starting with A' do
          let(:person) { create(:person, name: 'Arya Stark') }

          before { animal.person = person }

          it 'invalidates the ownership' do
            expect(animal).to be_invalid
            expect(animal.errors[:person]).to include('cannot have cats')
          end
        end

        context 'and person has a name starting with any letter but A' do
          let(:person) { create(:person, name: 'Sansa Stark') }

          before { animal.person = person }

          it 'validates the ownership' do
            expect(animal).to be_valid
            expect(animal.errors[:person]).to_not include('cannot have cats')
          end
        end
      end

      context 'when animal is a swallow' do
        let(:animal) { create(:swallow) }

        context 'when person is under 18 years old' do
          let(:person) { create(:person, birthdate: Date.tomorrow - 18.years) }

          before { animal.person = person }

          it 'invalidates the ownership' do
            expect(animal).to be_invalid
            expect(animal.errors[:person]).to include('cannot have swallows')
          end
        end

        context 'when person is 18 years old' do
          let(:person) { create(:person, birthdate: Date.today - 18.years) }

          before { animal.person = person }

          it 'validates the ownership' do
            expect(animal).to be_valid
            expect(animal.errors[:person]).to_not include('cannot have swallows')
          end
        end

        context 'when person is over 18 years old' do
          let(:person) { create(:person, birthdate: Date.yesterday - 18.years) }

          before { animal.person = person }

          it 'validates the ownership' do
            expect(animal).to be_valid
            expect(animal.errors[:person]).to_not include('cannot have swallows')
          end
        end
      end
    end
  end
end
