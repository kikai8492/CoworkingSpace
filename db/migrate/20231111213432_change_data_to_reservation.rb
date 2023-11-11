class ChangeDataToReservation < ActiveRecord::Migration[6.1]
  def change
    change_column :reservations, :reservation_date, 'timestamp without time zone USING CAST(\'1970-01-01\' || reservation_date::text AS timestamp without time zone)', null: false
  end
end
