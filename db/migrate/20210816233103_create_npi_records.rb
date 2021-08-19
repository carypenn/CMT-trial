class CreateNpiRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :npi_records do |t|
      t.string :number
      t.string :name
      t.string :address
      t.string :type
      t.text :taxonomy

      t.timestamps
    end
  end
end
