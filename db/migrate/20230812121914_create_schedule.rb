class CreateSchedule < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.boolean :sunday, default: false
      t.boolean :monday, default: false
      t.boolean :tuesday, default: false
      t.boolean :wednesday, default: false
      t.boolean :thursday, default: false
      t.boolean :friday, default: false
      t.boolean :saturday, default: false

      t.timestamps
    end

    add_reference :schedules, :todo, foreign_key: true
  end
end
