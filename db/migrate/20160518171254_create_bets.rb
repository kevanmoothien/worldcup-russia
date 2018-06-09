class CreateBets < ActiveRecord::Migration[4.2]
  def change
    create_table :bets, id: :uuid do |t|
      t.integer :score_a
      t.integer :score_b
      t.integer :user_id
      t.uuid :match_id
      t.uuid :public_id, default: 'uuid_generate_v4()'

      t.timestamps null: false
    end
  end
end
