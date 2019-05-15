class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :kind
      t.float :monthly_cost
      t.references :owner

      t.timestamps
    end
  end
end
