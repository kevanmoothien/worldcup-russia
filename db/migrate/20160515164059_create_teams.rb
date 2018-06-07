class CreateTeams < ActiveRecord::Migration[4.2]
  def change
    create_table :teams, id: :uuid do |t|
      t.string :name
      t.string :api_name

      t.timestamps null: false
    end
  end
end
