class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.time :reservation_date

      t.timestamps
    end
  end
end
