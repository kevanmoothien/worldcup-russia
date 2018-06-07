class CreateMatches < ActiveRecord::Migration[4.2]
  def change
    create_table :matches, id: :uuid do |t|
      t.integer :team_a
      t.integer :team_b
      t.integer :score_a
      t.integer :score_b
      t.datetime :schedule
      t.uuid :public_id, default: 'uuid_generate_v4()'

      t.timestamps null: false
    end
  end
end
