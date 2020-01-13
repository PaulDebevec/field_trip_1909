class AddAgeToPassengers < ActiveRecord::Migration[5.2]
  def change
    add_column :passengers, :age, :integer
  end
end
