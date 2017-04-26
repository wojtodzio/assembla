class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, index: true
      t.string :password, null: false

      t.timestamps
    end
  end
end