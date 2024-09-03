class CreateWeathers < ActiveRecord::Migration[6.1]
  def change
    create_table :weathers do |t|
      t.float :temperature
      t.integer :epoch_time

      t.timestamps
    end
  end
end
